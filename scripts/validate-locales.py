#!/usr/bin/env python3
"""Validate locale coverage and locale hygiene across the 5Dim mods.

Three read-only checks, none of which ever writes a file:

1. CRITICO - inline ``localised_name`` / ``localised_description`` in .lua.
   Texts must live in ``locale/en/*.cfg``, never in the prototype (CLAUDE.md).
   ``localised_name = nil`` is allowed: it resets a vanilla name so Factorio
   falls back to the locale lookup.
2. DESYNC - a module's ``locale/en`` must match its aggregated file in
   ``5dim_locale/locale/en``, and ``en`` must match ``en.example``. Compared
   key by key inside each section, so ordering and comments do not matter.
3. FALTANTE - prototypes declared in .lua with no entry in any English .cfg.

Examples:
    ./scripts/validate-locales.py
    ./scripts/validate-locales.py --mods-root ~/factorioMods
    ./scripts/validate-locales.py --exclude 5dim_dev --exclude 5dim_decoration

Exit codes: 0 clean, 1 inline localised_* or desynchronised locales.
Missing keys are reported but do not fail the run.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

DEFAULT_EXCLUDED = ("5dim_decoration", "5dim_dev", "5dim_locale")

AGGREGATE_MOD = "5dim_locale"
AGGREGATE_EN = Path("locale") / "en"
AGGREGATE_EXAMPLE = Path("locale") / "en.example"

# Module -> file name inside 5dim_locale/locale/en. Derived from the mod name
# minus the 5dim_ prefix, except where the aggregated file was named otherwise.
AGGREGATE_NAME_OVERRIDES = {"5dim_logistic": "logistics"}

# Modules with no aggregated file on purpose (no player-facing text to ship).
NO_AGGREGATE = {"5dim_dev", "5dim_modpack"}

# Prototype type -> locale section. Only the subset 5Dim actually declares.
TYPE_TO_SECTION = {
    "item": "item-name",
    "item-with-entity-data": "item-name",
    "capsule": "item-name",
    "ammo": "item-name",
    "armor": "item-name",
    "gun": "item-name",
    "tool": "item-name",
    "module": "item-name",
    "rail-planner": "item-name",
    "repair-tool": "item-name",
    "spidertron-remote": "item-name",
    "recipe": "recipe-name",
    "technology": "technology-name",
    "fluid": "fluid-name",
    "equipment-grid": "equipment-grid-name",
    "battery-equipment": "equipment-name",
    "energy-shield-equipment": "equipment-name",
    "movement-bonus-equipment": "equipment-name",
    "generator-equipment": "equipment-name",
    "solar-panel-equipment": "equipment-name",
    "roboport-equipment": "equipment-name",
    "belt-immunity-equipment": "equipment-name",
    "night-vision-equipment": "equipment-name",
    "active-defense-equipment": "equipment-name",
    "inventory-bonus-equipment": "equipment-name",
    "ammo-category": "ammo-category-name",
}

ENTITY_TYPES = (
    "container logistic-container storage-tank transport-belt underground-belt "
    "splitter loader loader-1x1 inserter pipe pipe-to-ground pump "
    "electric-pole small-electric-pole medium-electric-pole big-electric-pole "
    "substation accumulator solar-panel boiler generator reactor "
    "heat-pipe heat-interface lab assembling-machine furnace rocket-silo "
    "mining-drill offshore-pump beacon radar lamp wall gate turret "
    "ammo-turret electric-turret fluid-turret car tank spider-vehicle "
    "locomotive cargo-wagon fluid-wagon artillery-wagon roboport "
    "logistic-robot construction-robot combat-robot rail straight-rail "
    "curved-rail train-stop rail-signal rail-chained-signal "
    "unit unit-spawner spitter biter worm-turret simple-entity "
    "simple-entity-with-owner programmable-speaker arithmetic-combinator "
    "decider-combinator constant-combinator power-switch market "
    "agricultural-tower asteroid-collector cargo-bay cargo-landing-pad "
    "crusher fusion-generator fusion-reactor lightning-attractor "
    "thruster space-platform-hub captive-biter-spawner"
).split()
for entity_type in ENTITY_TYPES:
    TYPE_TO_SECTION[entity_type] = "entity-name"

PROTOTYPE_RE = re.compile(
    r'type\s*=\s*"([a-zA-Z0-9\-_]+)"\s*,\s*name\s*=\s*"([a-zA-Z0-9\-_]+)"'
)
SECTION_RE = re.compile(r"^\s*\[([^\]]+)\]\s*$")
KEY_RE = re.compile(r"^\s*([^=;\s][^=]*?)\s*=")
INLINE_LOCALISED_RE = re.compile(r"localised_(?:name|description)\s*=(?!\s*nil\b)")
# Ingredient/result tables also carry type= and name=; they are not prototypes.
INGREDIENT_RE = re.compile(
    r"\b(amount|probability|catalyst_amount|amount_min|amount_max)\s*="
)

SKIPPED_LUA_DIRS = {"locale", "graphics", "sound", "migrations"}


def read_cfg(path: Path) -> dict[str, dict[str, str]]:
    """Parse a .cfg into {section: {key: value}}."""
    sections: dict[str, dict[str, str]] = {}
    current: str | None = None
    for line in path.read_text(encoding="utf-8-sig", errors="replace").splitlines():
        section_match = SECTION_RE.match(line)
        if section_match:
            current = section_match.group(1)
            sections.setdefault(current, {})
            continue
        if current is None:
            continue
        stripped = line.strip()
        if not stripped or stripped.startswith(";"):
            continue
        key_match = KEY_RE.match(line)
        if key_match:
            key = key_match.group(1).strip()
            sections[current][key] = line.split("=", 1)[1].strip()
    return sections


def merge_cfg_dir(directory: Path) -> dict[str, dict[str, str]]:
    """Merge every .cfg in a directory into a single {section: {key: value}}."""
    merged: dict[str, dict[str, str]] = {}
    if not directory.is_dir():
        return merged
    for cfg in sorted(directory.glob("*.cfg")):
        for section, entries in read_cfg(cfg).items():
            merged.setdefault(section, {}).update(entries)
    return merged


def lua_files(mod_path: Path) -> list[Path]:
    return [
        path
        for path in sorted(mod_path.rglob("*.lua"))
        if not SKIPPED_LUA_DIRS & set(path.relative_to(mod_path).parts[:-1])
    ]


def aggregate_file_name(mod_name: str) -> str:
    override = AGGREGATE_NAME_OVERRIDES.get(mod_name)
    return override or mod_name.removeprefix("5dim_")


def check_inline_localised(mod_path: Path, files: list[Path], root: Path) -> list[str]:
    hits: list[str] = []
    for path in files:
        for number, line in enumerate(
            path.read_text(encoding="utf-8", errors="replace").splitlines(), start=1
        ):
            if INLINE_LOCALISED_RE.search(line):
                hits.append(f"{path.relative_to(root)}:{number}  {line.strip()}")
    return hits


def compare_sections(
    left: dict[str, dict[str, str]],
    right: dict[str, dict[str, str]],
    left_label: str,
    right_label: str,
) -> list[str]:
    """Key-by-key comparison of two parsed locale trees."""
    problems: list[str] = []
    for section in sorted(set(left) | set(right)):
        left_keys = left.get(section, {})
        right_keys = right.get(section, {})
        for key in sorted(set(left_keys) - set(right_keys)):
            problems.append(f"[{section}] {key}: solo en {left_label}")
        for key in sorted(set(right_keys) - set(left_keys)):
            problems.append(f"[{section}] {key}: solo en {right_label}")
        for key in sorted(set(left_keys) & set(right_keys)):
            if left_keys[key] != right_keys[key]:
                problems.append(
                    f"[{section}] {key}: texto distinto "
                    f"({left_label}={left_keys[key]!r} / {right_label}={right_keys[key]!r})"
                )
    return problems


def check_missing_keys(
    files: list[Path], known: dict[str, dict[str, str]]
) -> tuple[list[str], int]:
    missing: list[str] = []
    scanned = 0
    for path in files:
        content = path.read_text(encoding="utf-8", errors="replace")
        for match in PROTOTYPE_RE.finditer(content):
            prototype_type, name = match.group(1), match.group(2)
            section = TYPE_TO_SECTION.get(prototype_type)
            if section is None:
                continue
            # `"5d-tank-" .. tier` style prefixes are not real prototype names.
            if name.endswith("-"):
                continue
            tail = content[match.end() : match.end() + 120]
            if INGREDIENT_RE.search(tail):
                continue
            scanned += 1
            if name not in known.get(section, {}):
                missing.append(f"[{section}] {name}  (type={prototype_type})")
    return missing, scanned


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Revisa la cobertura y la coherencia de locales de los mods 5Dim."
    )
    parser.add_argument(
        "--mods-root",
        default=str(REPO_ROOT),
        help="Carpeta con los mods 5Dim (por defecto la raiz del repo).",
    )
    parser.add_argument(
        "--exclude",
        action="append",
        default=[],
        help=f"Mod a ignorar (repetible). Por defecto: {', '.join(DEFAULT_EXCLUDED)}.",
    )
    parser.add_argument(
        "--max-listed",
        type=int,
        default=25,
        help="Cuantos problemas se listan por mod y categoria (por defecto 25).",
    )
    args = parser.parse_args(argv)

    root = Path(args.mods_root).expanduser().resolve()
    excluded = set(args.exclude) | set(DEFAULT_EXCLUDED)

    aggregate_root = root / AGGREGATE_MOD
    aggregate_en = merge_cfg_dir(aggregate_root / AGGREGATE_EN)

    total_critical = 0
    total_desync = 0
    total_missing = 0

    def report(items: list[str], indent: str = "    ") -> None:
        for item in items[: args.max_listed]:
            print(f"{indent}{item}")
        if len(items) > args.max_listed:
            print(f"{indent}... ({len(items) - args.max_listed} mas)")

    # --- en vs en.example (the shipped pool and the translator template) ---
    example_problems = compare_sections(
        aggregate_en,
        merge_cfg_dir(aggregate_root / AGGREGATE_EXAMPLE),
        "en",
        "en.example",
    )
    print(f"=== {AGGREGATE_MOD} (en vs en.example) ===")
    if example_problems:
        print(f"  [DESYNC] {len(example_problems)} diferencias:")
        report(example_problems)
        total_desync += len(example_problems)
    else:
        print("  en y en.example coinciden.")

    mods = sorted(
        path
        for path in root.glob("5dim_*")
        if path.is_dir() and path.name not in excluded
    )

    for mod_path in mods:
        mod_name = mod_path.name
        print()
        print(f"=== {mod_name} ===")

        files = lua_files(mod_path)

        inline = check_inline_localised(mod_path, files, root)
        if inline:
            print(f"  [CRITICO] localised_* inline ({len(inline)}):")
            report(inline)
            total_critical += len(inline)

        module_en = merge_cfg_dir(mod_path / "locale" / "en")

        # --- sync with the aggregated pool in 5dim_locale ---
        if mod_name not in NO_AGGREGATE:
            aggregate_path = (
                aggregate_root / AGGREGATE_EN / f"{aggregate_file_name(mod_name)}.cfg"
            )
            if not aggregate_path.exists():
                print(f"  [DESYNC] no existe {aggregate_path.relative_to(root)}")
                total_desync += 1
            else:
                desync = compare_sections(
                    module_en,
                    read_cfg(aggregate_path),
                    mod_name,
                    aggregate_path.name,
                )
                if desync:
                    print(f"  [DESYNC] {len(desync)} diferencias con 5dim_locale:")
                    report(desync)
                    total_desync += len(desync)

        # --- locale coverage: module keys plus the shared aggregated pool ---
        known: dict[str, dict[str, str]] = {
            section: dict(entries) for section, entries in module_en.items()
        }
        for section, entries in aggregate_en.items():
            known.setdefault(section, {}).update(entries)

        missing, scanned = check_missing_keys(files, known)
        if missing:
            print(f"  Claves de locale faltantes: {len(missing)} (de {scanned} prototipos)")
            report([f"[FALTANTE] {item}" for item in missing])
            total_missing += len(missing)
        else:
            print(f"  Cobertura de locale OK ({scanned} prototipos).")

    print()
    print("--- Resumen ---")
    print(f"CRITICO  localised_* inline: {total_critical}")
    print(f"DESYNC   locales desincronizados: {total_desync}")
    print(f"FALTANTE claves sin traducir: {total_missing}")

    return 1 if (total_critical or total_desync) else 0


if __name__ == "__main__":
    sys.exit(main())
