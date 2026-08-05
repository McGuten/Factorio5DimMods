#!/usr/bin/env python3
"""Run local Factorio load-validation profiles for the 5Dim mod suite.

For every profile it builds a throwaway mod directory (symlinks to the repo),
a throwaway ``mod-list.json`` and a throwaway ``config.ini`` outside the repo,
then launches Factorio in data-stage validation mode (``--dump-data``), which
exits on its own and needs no display. Nothing tracked by git is modified.

Cross-platform: works both from the WSL/Linux clone (Factorio in
``$FACTORIO_DIR``, default ``~/factorio``) and from the Windows workspace,
where the repo lives in ``<workspace>/mods`` next to ``bin/`` and ``data/``.

Examples:
    ./scripts/validate-factorio-profiles.py --list-profiles
    ./scripts/validate-factorio-profiles.py --test-set smoke
    ./scripts/validate-factorio-profiles.py --test-set module --jobs 4
    ./scripts/validate-factorio-profiles.py --profiles suite-full,module-5dim_transport

Exit codes: 0 all good, 1 some profile failed, 2 some profile timed out.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import time
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

# Official mods are auto-discovered from <factorio>/data. This table is only a
# fallback for when the data directory cannot be read, and documents the shape:
# name -> hard dependencies. `quality` and `space-age` require `recycler`
# since 2.1, so any profile enabling them must enable it too.
FALLBACK_OFFICIAL_MODS = {
    "base": [],
    "elevated-rails": ["base"],
    "quality": ["base", "recycler"],
    "recycler": ["base"],
    "space-age": ["base", "elevated-rails", "quality", "recycler"],
}

# Not part of the "full suite" profiles: compatibility only reacts to third
# party mods, decoration is cosmetic and pulls no prototypes worth validating.
EXCLUDED_FROM_SUITE = {"5dim_compatibility", "5dim_decoration"}

# Modules that get `space-age` enabled in their individual profile even when
# they do not declare it as a hard dependency.
SPACE_AGE_MODULES = {"5dim_core", "5dim_module", "5dim_space_age", "5dim_transport"}

# Baseline official surface for the per-module profiles.
MODULE_BASE_OFFICIAL_MODS = ["base", "elevated-rails", "quality"]

WARNING_RE = re.compile(r"^\s*[\d.]+\s+Warning\b[:\s]*(?P<body>.*)$")
ERROR_LINE_RE = re.compile(r"^\s*[\d.]+\s+(?:Error|Exception)\b[:\s]*(?P<body>.*)$")
ERROR_BLOCK_RE = re.compile(r"^-+ Error -+$")
# A warning/error is "ours" when it names a 5Dim prototype or mod.
FIVEDIM_RE = re.compile(r"5d-|5dim", re.IGNORECASE)
# Collapses per-tier prototype names so identical warnings group together.
PROTOTYPE_NAME_RE = re.compile(r"5d-[A-Za-z0-9_-]+", re.IGNORECASE)
ZIP_NAME_RE = re.compile(r"^(?P<name>.+)_(?P<version>\d+\.\d+.*)\.zip$")

# Distinct warning cases listed per profile in report.txt (summary.json has all).
MAX_LISTED_WARNING_GROUPS = 15

PRINT_LOCK = threading.Lock()


# --------------------------------------------------------------------------
# Mod catalog
# --------------------------------------------------------------------------


@dataclass(frozen=True)
class Dependency:
    name: str
    optional: bool
    conflict: bool


@dataclass(frozen=True)
class Mod:
    name: str
    version: str
    path: Path
    folder_name: str
    is_zip: bool
    dependencies: tuple[Dependency, ...]


def parse_dependency(descriptor: str) -> Dependency | None:
    """Parse an info.json dependency string ("? space-age >= 2.0.0")."""
    text = descriptor.strip()
    kind = ""
    for prefix in ("(?)", "?", "!", "~", "+"):
        if text.startswith(prefix):
            kind = prefix
            text = text[len(prefix) :].strip()
            break
    # Mod names may contain spaces ("Orbital Ion Cannon"), so cut at the
    # version comparator instead of matching a restricted character class.
    name = re.split(r"[<>=]", text, maxsplit=1)[0].strip()
    if not name:
        return None
    return Dependency(
        name=name,
        optional=kind in ("?", "(?)"),
        conflict=kind in ("!", "~"),
    )


def load_json(path: Path) -> dict:
    # Factorio ships some info.json files with a BOM.
    return json.loads(path.read_text(encoding="utf-8-sig"))


def read_dependencies(info: dict) -> tuple[Dependency, ...]:
    parsed = (parse_dependency(str(d)) for d in info.get("dependencies", []))
    return tuple(d for d in parsed if d is not None)


def build_catalog(mods_root: Path) -> dict[str, Mod]:
    """Every mod available to the runner: repo directories plus loose zips."""
    catalog: dict[str, Mod] = {}

    for info_path in sorted(mods_root.glob("*/info.json")):
        info = load_json(info_path)
        name = info.get("name")
        if not name:
            continue
        directory = info_path.parent
        catalog[name] = Mod(
            name=name,
            version=str(info.get("version", "")),
            path=directory,
            folder_name=directory.name,
            is_zip=False,
            dependencies=read_dependencies(info),
        )

    for zip_path in sorted(mods_root.glob("*.zip")):
        match = ZIP_NAME_RE.match(zip_path.name)
        if not match:
            continue
        name = match.group("name")
        if name in catalog:
            continue
        catalog[name] = Mod(
            name=name,
            version=match.group("version"),
            path=zip_path,
            folder_name=zip_path.name,
            is_zip=True,
            dependencies=(),
        )

    return catalog


def discover_official_mods(data_dir: Path) -> dict[str, list[str]]:
    """Official mods shipped with the installed Factorio, with their hard deps."""
    discovered: dict[str, list[str]] = {}
    for info_path in sorted(data_dir.glob("*/info.json")):
        try:
            info = load_json(info_path)
        except (OSError, ValueError):
            continue
        name = info.get("name")
        if not name or name == "core":
            continue
        discovered[name] = [
            d.name for d in read_dependencies(info) if not d.optional and not d.conflict
        ]
    return discovered or dict(FALLBACK_OFFICIAL_MODS)


# --------------------------------------------------------------------------
# Profiles
# --------------------------------------------------------------------------


@dataclass
class Profile:
    name: str
    kind: str
    description: str
    official_mods: list[str]
    mod_names: list[str]
    notes: list[str] = field(default_factory=list)

    @property
    def blocking_note(self) -> str | None:
        for note in self.notes:
            if note.startswith("faltan mods requeridos:"):
                return note
        return None


def close_official_mods(names, official: dict[str, list[str]]) -> list[str]:
    """Add the official mods required by the requested ones (quality -> recycler)."""
    selected: set[str] = set()
    pending = list(names)
    while pending:
        name = pending.pop()
        if name in selected or name not in official:
            continue
        selected.add(name)
        pending.extend(official[name])
    return sorted(selected)


def required_deps(mod: Mod) -> list[str]:
    return [d.name for d in mod.dependencies if not d.optional and not d.conflict]


def compatible_suite_modules(
    candidates: list[str],
    enabled_official: set[str],
    catalog: dict[str, Mod],
    official: dict[str, list[str]],
) -> tuple[list[str], list[str]]:
    """Split candidates into those loadable with this DLC set and those not."""
    selected: list[str] = []
    omitted: list[str] = []

    for name in sorted(candidates):
        mod = catalog[name]
        deps = required_deps(mod)

        missing_official = sorted(
            {d for d in deps if d in official and d not in enabled_official}
        )
        if missing_official:
            omitted.append(f"{name} (falta oficial: {', '.join(missing_official)})")
            continue

        missing_external = sorted(
            {
                d
                for d in deps
                if d not in official and not d.startswith("5dim_") and d not in catalog
            }
        )
        if missing_external:
            omitted.append(f"{name} (falta externo: {', '.join(missing_external)})")
            continue

        selected.append(name)

    return selected, omitted


def resolve_mod_closure(
    seeds: list[str],
    enabled_official: set[str],
    catalog: dict[str, Mod],
) -> tuple[list[str], list[str]]:
    """Walk hard dependencies; return the mods to enable and what is missing."""
    selected: set[str] = set()
    missing: set[str] = set()
    pending = sorted(set(seeds))

    while pending:
        name = pending.pop()
        if name in selected:
            continue
        if name not in catalog:
            missing.add(name)
            continue

        selected.add(name)
        for dep in required_deps(catalog[name]):
            if dep in enabled_official:
                continue
            if dep in catalog:
                if dep not in selected:
                    pending.append(dep)
                continue
            missing.add(f"{name} -> {dep}")

    return sorted(selected), sorted(missing)


def recommended_official_for_module(
    module_name: str,
    catalog: dict[str, Mod],
    official: dict[str, list[str]],
) -> list[str]:
    wanted = {m for m in MODULE_BASE_OFFICIAL_MODS if m in official}
    if module_name in SPACE_AGE_MODULES and "space-age" in official:
        wanted.add("space-age")
    for dep in catalog[module_name].dependencies:
        if dep.name in official and not dep.conflict:
            wanted.add(dep.name)
    return close_official_mods(wanted, official)


def build_profiles(
    test_set: str,
    catalog: dict[str, Mod],
    official: dict[str, list[str]],
) -> list[Profile]:
    profiles: list[Profile] = []
    fivedim = [n for n in sorted(catalog) if n.startswith("5dim_")]
    suite_candidates = [n for n in fivedim if n not in EXCLUDED_FROM_SUITE]

    if test_set in ("smoke", "all"):
        suite_specs = [
            (
                "suite-no-dlc",
                "Suite 5Dim completa sin ningun DLC oficial.",
                ["base"],
            ),
            (
                "suite-no-space-age",
                "Suite 5Dim con Quality y Elevated Rails, pero sin Space Age.",
                ["base", "elevated-rails", "quality"],
            ),
            (
                "suite-full",
                "Suite 5Dim con Space Age, Quality y Elevated Rails.",
                sorted(official),
            ),
        ]

        for name, description, requested in suite_specs:
            enabled_official = close_official_mods(requested, official)
            selected, omitted = compatible_suite_modules(
                suite_candidates, set(enabled_official), catalog, official
            )
            mod_names, missing = resolve_mod_closure(
                selected, set(enabled_official), catalog
            )
            notes = list(omitted)
            if missing:
                notes.append(f"faltan mods requeridos: {', '.join(missing)}")
            profiles.append(
                Profile(name, "suite", description, enabled_official, mod_names, notes)
            )

    if test_set in ("module", "all"):
        core_official = recommended_official_for_module("5dim_core", catalog, official)
        core_mods, core_missing = resolve_mod_closure(
            ["5dim_core"], set(core_official), catalog
        )
        profiles.append(
            Profile(
                "module-core-only",
                "module",
                "5dim_core en solitario, con la superficie oficial maxima.",
                core_official,
                core_mods,
                [f"faltan mods requeridos: {', '.join(core_missing)}"]
                if core_missing
                else [],
            )
        )

        targets = [
            n
            for n in fivedim
            if n != "5dim_core" and n not in EXCLUDED_FROM_SUITE
        ]
        for module_name in targets:
            enabled_official = recommended_official_for_module(
                module_name, catalog, official
            )
            mod_names, missing = resolve_mod_closure(
                ["5dim_core", module_name], set(enabled_official), catalog
            )
            notes = (
                [f"faltan mods requeridos: {', '.join(missing)}"] if missing else []
            )
            profiles.append(
                Profile(
                    f"module-{module_name}",
                    "module",
                    f"5dim_core mas {module_name} en solitario.",
                    enabled_official,
                    mod_names,
                    notes,
                )
            )

    return sorted(profiles, key=lambda p: p.name)


def filter_profiles(profiles: list[Profile], wanted: list[str]) -> list[Profile]:
    if not wanted:
        return profiles
    requested = {
        piece.strip().lower()
        for entry in wanted
        for piece in entry.split(",")
        if piece.strip()
    }
    return [p for p in profiles if p.name.lower() in requested]


# --------------------------------------------------------------------------
# Environment and execution
# --------------------------------------------------------------------------


@dataclass
class Environment:
    profile_root: Path
    mod_directory: Path
    write_data: Path
    config_path: Path
    log_path: Path
    previous_log_path: Path
    script_output: Path
    stdout_path: Path
    stderr_path: Path


def link_or_copy(target: Path, link: Path) -> None:
    if link.exists() or link.is_symlink():
        return
    if target.is_file():
        shutil.copy2(target, link)
        return
    try:
        link.symlink_to(target, target_is_directory=True)
    except (OSError, NotImplementedError):
        # Windows without developer mode: fall back to a directory junction.
        subprocess.run(
            ["cmd", "/c", "mklink", "/J", str(link), str(target)],
            check=True,
            stdout=subprocess.DEVNULL,
        )


def build_environment(
    profile: Profile,
    catalog: dict[str, Mod],
    official: dict[str, list[str]],
    run_root: Path,
    data_dir: Path,
) -> Environment:
    profile_root = run_root / profile.name
    mod_directory = profile_root / "mods"
    write_data = profile_root / "write-data"
    mod_directory.mkdir(parents=True, exist_ok=True)
    write_data.mkdir(parents=True, exist_ok=True)

    for name in profile.mod_names:
        mod = catalog[name]
        link_or_copy(mod.path, mod_directory / mod.folder_name)

    # Every official mod needs an explicit entry: mods missing from the list are
    # enabled by default, which would silently load DLC in the no-DLC profiles.
    entries = [
        {"name": name, "enabled": name in profile.official_mods}
        for name in sorted(official)
    ]
    entries += [{"name": name, "enabled": True} for name in sorted(profile.mod_names)]
    (mod_directory / "mod-list.json").write_text(
        json.dumps({"mods": entries}, indent=2), encoding="utf-8"
    )

    config_path = profile_root / "config.ini"
    config_path.write_text(
        "[path]\n"
        f"read-data={data_dir.as_posix()}\n"
        f"write-data={write_data.as_posix()}\n"
        "\n"
        "[general]\n"
        "locale=en\n",
        encoding="utf-8",
    )

    return Environment(
        profile_root=profile_root,
        mod_directory=mod_directory,
        write_data=write_data,
        config_path=config_path,
        log_path=write_data / "factorio-current.log",
        previous_log_path=write_data / "factorio-previous.log",
        script_output=write_data / "script-output",
        stdout_path=profile_root / "factorio.stdout.log",
        stderr_path=profile_root / "factorio.stderr.log",
    )


def read_log(path: Path | None) -> list[str]:
    if path is None or not path.exists():
        return []
    return path.read_text(encoding="utf-8", errors="replace").splitlines()


def first_error(lines: list[str]) -> str | None:
    """Prefer the framed error block Factorio prints; fall back to Error lines."""
    for index, line in enumerate(lines):
        if ERROR_BLOCK_RE.match(line.strip()):
            body = []
            for candidate in lines[index + 1 :]:
                if candidate.strip().startswith("---"):
                    break
                if candidate.strip():
                    body.append(candidate.strip())
            if body:
                return " | ".join(body)
    for line in lines:
        match = ERROR_LINE_RE.match(line)
        if match:
            return match.group("body").strip() or line.strip()
    return None


def classify_warnings(lines: list[str]) -> tuple[dict[str, int], int, int]:
    """Group the 5Dim warnings by shape and count the vanilla ones.

    A tiered mod emits the same warning once per tier, so the raw list is
    hundreds of near-identical lines. Collapsing the prototype name turns that
    into a handful of distinct problems.
    """
    groups: dict[str, int] = {}
    ours = 0
    vanilla = 0
    for line in lines:
        match = WARNING_RE.match(line)
        if not match:
            continue
        body = match.group("body").strip()
        if not FIVEDIM_RE.search(body):
            vanilla += 1
            continue
        ours += 1
        shape = PROTOTYPE_NAME_RE.sub("<5d-*>", body)
        groups[shape] = groups.get(shape, 0) + 1
    return groups, ours, vanilla


def has_success_markers(lines: list[str]) -> bool:
    text = "\n".join(lines)
    return "Factorio initialised" in text and "Goodbye" in text


@dataclass
class Result:
    name: str
    kind: str
    status: str
    exit_code: int | None
    duration_seconds: float
    official_mods: list[str]
    enabled_mods: list[str]
    warnings_5dim: int
    warnings_vanilla: int
    warning_groups: list[dict]
    summary: str
    log_path: str | None
    profile_root: str
    notes: list[str]


def run_profile(
    profile: Profile,
    environment: Environment,
    binary: Path,
    timeout: int,
    dump_data: bool,
    keep_artifacts: bool,
) -> Result:
    blocking = profile.blocking_note
    if blocking:
        return Result(
            name=profile.name,
            kind=profile.kind,
            status="Omitido",
            exit_code=None,
            duration_seconds=0.0,
            official_mods=profile.official_mods,
            enabled_mods=profile.mod_names,
            warnings_5dim=0,
            warnings_vanilla=0,
            warning_groups=[],
            summary=blocking,
            log_path=None,
            profile_root=str(environment.profile_root),
            notes=profile.notes,
        )

    arguments = [
        str(binary),
        "--config",
        str(environment.config_path),
        "--mod-directory",
        str(environment.mod_directory),
        "--check-unused-prototype-data",
    ]
    if dump_data:
        arguments.append("--dump-data")

    # --dump-data never opens a window; drop the display so a stray SDL probe
    # cannot pop one up or block on a headless session.
    child_env = {k: v for k, v in os.environ.items()}
    child_env.pop("DISPLAY", None)
    child_env.pop("WAYLAND_DISPLAY", None)

    started = time.monotonic()
    timed_out = False
    exit_code: int | None = None

    with environment.stdout_path.open("wb") as stdout, environment.stderr_path.open(
        "wb"
    ) as stderr:
        process = subprocess.Popen(
            arguments, stdout=stdout, stderr=stderr, env=child_env
        )
        try:
            exit_code = process.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            timed_out = True
            process.kill()
            process.wait()

    duration = round(time.monotonic() - started, 2)

    log_path: Path | None = None
    if environment.log_path.exists():
        log_path = environment.log_path
    elif environment.previous_log_path.exists():
        log_path = environment.previous_log_path

    lines = read_log(log_path)
    warning_groups, ours, vanilla = classify_warnings(lines)
    log_error = first_error(lines)

    if not keep_artifacts and environment.script_output.exists():
        shutil.rmtree(environment.script_output, ignore_errors=True)

    if timed_out:
        status, summary = "Timeout", "Factorio no termino antes del timeout."
    elif exit_code:
        status = "Fallido"
        summary = log_error or f"Factorio salio con codigo {exit_code}."
    elif log_error:
        status, summary = "Fallido", log_error
    elif not lines:
        status, summary = "Fallido", "No se encontro el log de Factorio."
    elif not has_success_markers(lines):
        status, summary = "Fallido", "El log no tiene marcadores de exito."
    else:
        status, summary = "Pasado", "Factorio termino correctamente."

    return Result(
        name=profile.name,
        kind=profile.kind,
        status=status,
        exit_code=exit_code,
        duration_seconds=duration,
        official_mods=profile.official_mods,
        enabled_mods=profile.mod_names,
        warnings_5dim=ours,
        warnings_vanilla=vanilla,
        warning_groups=[
            {"count": count, "message": message}
            for message, count in sorted(
                warning_groups.items(), key=lambda item: (-item[1], item[0])
            )
        ],
        summary=summary,
        log_path=str(log_path) if log_path else None,
        profile_root=str(environment.profile_root),
        notes=profile.notes,
    )


# --------------------------------------------------------------------------
# Reporting
# --------------------------------------------------------------------------


def print_profile_list(profiles: list[Profile]) -> None:
    for profile in profiles:
        print(f"- {profile.name}")
        print(f"    Tipo:      {profile.kind}")
        print(f"    Oficiales: {', '.join(profile.official_mods)}")
        print(f"    Mods:      {', '.join(profile.mod_names)}")
        if profile.notes:
            print(f"    Notas:     {' | '.join(profile.notes)}")


def build_report(results: list[Result], run_root: Path) -> str:
    by_status = {
        status: [r for r in results if r.status == status]
        for status in ("Pasado", "Fallido", "Omitido", "Timeout")
    }
    warnings_5dim = sum(r.warnings_5dim for r in results)
    warnings_vanilla = sum(r.warnings_vanilla for r in results)
    total_duration = round(sum(r.duration_seconds for r in results), 2)

    lines = [
        "Informe breve de tests",
        f"- Perfiles ejecutados: {len(results)}",
        f"- Pasados: {len(by_status['Pasado'])}",
        f"- Fallidos: {len(by_status['Fallido'])}",
        f"- Omitidos: {len(by_status['Omitido'])}",
        f"- Timeout: {len(by_status['Timeout'])}",
        f"- Warnings 5Dim: {warnings_5dim}",
        f"- Warnings vanilla: {warnings_vanilla}",
        f"- Tiempo acumulado: {total_duration} s",
        f"- Artefactos: {run_root}",
    ]

    for status, title in (
        ("Fallido", "Fallos detectados:"),
        ("Timeout", "Perfiles con timeout:"),
        ("Omitido", "Perfiles omitidos:"),
    ):
        if by_status[status]:
            lines += ["", title]
            lines += [
                f"- {r.name}: {r.summary}"
                for r in sorted(by_status[status], key=lambda r: r.name)
            ]

    if by_status["Pasado"]:
        lines += ["", "Perfiles pasados:"]
        lines += [
            f"- {r.name}: {r.duration_seconds} s, warnings 5dim={r.warnings_5dim}, vanilla={r.warnings_vanilla}"
            for r in sorted(by_status["Pasado"], key=lambda r: r.name)
        ]

    flagged = [r for r in results if r.warning_groups]
    if flagged:
        lines += [
            "",
            "Warnings sobre prototipos 5Dim (agrupados, el nombre por tier colapsado):",
        ]
        for result in sorted(flagged, key=lambda r: r.name):
            lines.append(
                f"- {result.name}: {result.warnings_5dim} warnings "
                f"en {len(result.warning_groups)} casos distintos"
            )
            for group in result.warning_groups[:MAX_LISTED_WARNING_GROUPS]:
                lines.append(f"    {group['count']:>4}x  {group['message']}")
            remaining = len(result.warning_groups) - MAX_LISTED_WARNING_GROUPS
            if remaining > 0:
                lines.append(f"    ... ({remaining} casos mas, ver summary.json)")

    return "\n".join(lines)


def print_result_table(results: list[Result]) -> None:
    header = f"{'Perfil':<32} {'Estado':<9} {'Seg':>7} {'W5d':>5} {'Wvan':>5}  Resumen"
    print(header)
    print("-" * len(header))
    for result in sorted(results, key=lambda r: r.name):
        summary = result.summary
        if len(summary) > 70:
            summary = summary[:67] + "..."
        print(
            f"{result.name:<32} {result.status:<9} {result.duration_seconds:>7.2f} "
            f"{result.warnings_5dim:>5} {result.warnings_vanilla:>5}  {summary}"
        )


# --------------------------------------------------------------------------
# Entry point
# --------------------------------------------------------------------------


def resolve_factorio_dir(explicit: str | None) -> Path:
    if explicit:
        return Path(explicit).expanduser().resolve()

    env_dir = os.environ.get("FACTORIO_DIR")
    if env_dir:
        return Path(env_dir).expanduser().resolve()

    # Windows workspace: the repo sits in <workspace>/mods, next to bin/ and data/.
    workspace = REPO_ROOT.parent
    if (workspace / "data" / "base" / "info.json").exists():
        return workspace

    return (Path.home() / "factorio").resolve()


def resolve_binary(factorio_dir: Path, explicit: str | None) -> Path:
    if explicit:
        return Path(explicit).expanduser().resolve()
    for candidate in (
        factorio_dir / "bin" / "x64" / "factorio",
        factorio_dir / "bin" / "x64" / "factorio.exe",
    ):
        if candidate.exists():
            return candidate
    raise SystemExit(
        f"No se encuentra el binario de Factorio en {factorio_dir}/bin/x64.\n"
        "Usa --factorio-dir, --factorio-binary o la variable FACTORIO_DIR."
    )


def parse_arguments(argv: list[str] | None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Ejecuta los perfiles de validacion de carga de los mods 5Dim.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--mods-root",
        default=str(REPO_ROOT),
        help="Carpeta con los mods 5Dim (por defecto la raiz del repo).",
    )
    parser.add_argument(
        "--factorio-dir",
        help="Instalacion de Factorio (por defecto $FACTORIO_DIR o ~/factorio).",
    )
    parser.add_argument("--factorio-binary", help="Ruta explicita al ejecutable.")
    parser.add_argument(
        "--test-set",
        choices=("smoke", "module", "all"),
        default="smoke",
        help="smoke: suite en 3 combinaciones de DLC. module: core y core+modulo.",
    )
    parser.add_argument(
        "--profiles",
        action="append",
        default=[],
        help="Nombres de perfil concretos (repetible o separado por comas).",
    )
    parser.add_argument("--list-profiles", action="store_true")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument(
        "--jobs",
        type=int,
        default=min(4, os.cpu_count() or 1),
        help="Perfiles en paralelo (por defecto 4).",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=120,
        help="Segundos por perfil antes de matar Factorio (por defecto 120).",
    )
    parser.add_argument(
        "--output-root",
        default=str(Path(tempfile.gettempdir()) / "factorio-5dim-validation"),
        help="Carpeta donde se escriben los artefactos temporales.",
    )
    parser.add_argument(
        "--keep-artifacts",
        action="store_true",
        help="Conserva los dumps pesados de script-output.",
    )
    parser.add_argument("--stop-on-failure", action="store_true")
    parser.add_argument(
        "--no-dump-data",
        action="store_true",
        help="No pasa --dump-data (Factorio no saldria solo: usar con cuidado).",
    )
    parser.add_argument(
        "--run-locale-validation",
        action="store_true",
        help="Ejecuta validate-locales.py antes de lanzar Factorio.",
    )
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_arguments(argv)

    mods_root = Path(args.mods_root).expanduser().resolve()
    factorio_dir = resolve_factorio_dir(args.factorio_dir)
    data_dir = factorio_dir / "data"
    official = discover_official_mods(data_dir)

    catalog = build_catalog(mods_root)
    if not catalog:
        raise SystemExit(f"No se ha encontrado ningun mod en {mods_root}.")

    profiles = filter_profiles(
        build_profiles(args.test_set, catalog, official), args.profiles
    )
    if not profiles:
        raise SystemExit("Ningun perfil coincide con los filtros indicados.")

    if args.list_profiles or args.dry_run:
        print_profile_list(profiles)
        return 0

    binary = resolve_binary(factorio_dir, args.factorio_binary)

    if args.run_locale_validation:
        locale_validator = Path(__file__).with_name("validate-locales.py")
        completed = subprocess.run(
            [sys.executable, str(locale_validator), "--mods-root", str(mods_root)]
        )
        if completed.returncode != 0:
            raise SystemExit(
                f"La validacion de locales fallo (codigo {completed.returncode})."
            )

    run_root = (
        Path(args.output_root).expanduser().resolve()
        / f"run-{datetime.now():%Y%m%d-%H%M%S}"
    )
    run_root.mkdir(parents=True, exist_ok=True)

    print(f"Factorio:   {binary}")
    print(f"Mods:       {mods_root}")
    print(f"Artefactos: {run_root}")
    print(f"Perfiles:   {len(profiles)} (jobs={args.jobs})\n")

    environments = {
        profile.name: build_environment(profile, catalog, official, run_root, data_dir)
        for profile in profiles
    }

    def execute(profile: Profile) -> Result:
        result = run_profile(
            profile,
            environments[profile.name],
            binary,
            args.timeout,
            not args.no_dump_data,
            args.keep_artifacts,
        )
        with PRINT_LOCK:
            print(f"  {result.status:<9} {result.name} ({result.duration_seconds}s)")
        return result

    results: list[Result] = []
    if args.jobs <= 1 or args.stop_on_failure:
        # Serial: --stop-on-failure only means something with a defined order.
        for profile in profiles:
            result = execute(profile)
            results.append(result)
            if args.stop_on_failure and result.status in ("Fallido", "Timeout"):
                break
    else:
        with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
            results = list(pool.map(execute, profiles))

    summary_path = run_root / "summary.json"
    summary_path.write_text(
        json.dumps([r.__dict__ for r in results], indent=2, ensure_ascii=False),
        encoding="utf-8",
    )
    report = build_report(results, run_root)
    report_path = run_root / "report.txt"
    report_path.write_text(report, encoding="utf-8")

    print()
    print_result_table(results)
    print()
    print(report)
    print()
    print(f"summary.json: {summary_path}")
    print(f"report.txt:   {report_path}")

    if any(r.status == "Timeout" for r in results):
        return 2
    if any(r.status == "Fallido" for r in results):
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
