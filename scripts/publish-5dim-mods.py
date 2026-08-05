#!/usr/bin/env python3
"""Publish the 5dim_* mods to the Factorio Mod Portal (mods.factorio.com).

Dry-run by default: it queries the portal, compares versions and prints what it
would do, without uploading anything. It only uploads with --publish.

Needs a Mod Portal API key in scripts/.portal-key (a single line), created at
https://factorio.com/profile with permissions:
  - "ModPortal: Upload Mods"   (upload new versions of an existing mod)
  - "ModPortal: Publish Mods"  (publish a mod that is not on the portal yet)

The key file is never read unless --publish is passed, and is gitignored.

Examples:
    ./scripts/publish-5dim-mods.py
    ./scripts/publish-5dim-mods.py --keep-zips /tmp/zips
    ./scripts/publish-5dim-mods.py --publish --mods 5dim_core,5dim_mining

Exit codes: 0 all good, 1 some upload failed.
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
import tempfile
import urllib.parse
import urllib.request
import zipfile
from dataclasses import dataclass
from pathlib import Path, PurePosixPath

REPO_ROOT = Path(__file__).resolve().parents[1]

PORTAL_API = "https://mods.factorio.com/api/mods"
UPLOAD_API = "https://mods.factorio.com/api/v2/mods"
NEW_MOD_LICENSE = "default_mit"
NEW_MOD_SOURCE_URL = "https://github.com/McGuten/Factorio5DimMods"

ALWAYS_EXCLUDED_MODS = ("5dim_decoration", "5dim_dev", "5dim_compatibility")

# Content that must never end up inside a published zip. '*.zip' matters: mod
# folders accumulate old releases worth hundreds of MB, and without this filter
# every one of them would ride along in the upload.
EXCLUDED_NAMES = ("*.zip", ".git*", ".vscode", ".DS_Store")

CHANGELOG_VERSION_RE = "(?m)^Version:[ \t]*{}[ \t]*$"


@dataclass
class LocalMod:
    name: str
    version: str
    directory: Path

    @property
    def package_name(self) -> str:
        return f"{self.name}_{self.version}"


@dataclass
class PlanEntry:
    mod: LocalMod
    portal_version: str | None
    action: str  # PUBLISH | UPLOAD | SKIP
    warning: str


def parse_version(text: str) -> tuple[int, ...]:
    """Turn '2.1.0' into (2, 1, 0) for ordering. Non-numeric parts sort as 0."""
    parts = []
    for piece in str(text).strip().split("."):
        parts.append(int(piece) if piece.isdigit() else 0)
    return tuple(parts)


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8-sig"))


def discover_mods(
    mods_root: Path, only: list[str], excluded: set[str]
) -> list[LocalMod]:
    mods: list[LocalMod] = []
    for info_path in sorted(mods_root.glob("5dim_*/info.json")):
        directory = info_path.parent
        if directory.name in excluded:
            continue
        info = load_json(info_path)
        name, version = info.get("name"), info.get("version")
        if not name or not version:
            raise SystemExit(f"Falta name o version en {info_path}.")
        mods.append(LocalMod(str(name), str(version), directory))

    if only:
        known = {mod.directory.name for mod in mods} | {mod.name for mod in mods}
        unknown = [entry for entry in only if entry not in known]
        if unknown:
            raise SystemExit(
                f"Mods no encontrados (o excluidos): {', '.join(unknown)}"
            )
        mods = [m for m in mods if m.name in only or m.directory.name in only]

    if not mods:
        raise SystemExit(f"No se ha encontrado ningun mod 5dim en {mods_root}.")
    return mods


def get_portal_versions(names: list[str]) -> dict[str, str]:
    """Latest published version per mod, for the mods that exist on the portal."""
    query = "&".join(f"namelist={urllib.parse.quote(name)}" for name in names)
    url = f"{PORTAL_API}?page_size=max&{query}"

    with urllib.request.urlopen(url, timeout=60) as response:
        payload = json.loads(response.read().decode("utf-8"))

    versions: dict[str, str] = {}
    for result in payload.get("results", []):
        latest = (result.get("latest_release") or {}).get("version")
        if not latest:
            releases = [r.get("version") for r in result.get("releases") or []]
            releases = [r for r in releases if r]
            latest = max(releases, key=parse_version) if releases else None
        if latest:
            versions[result["name"]] = latest
    return versions


def check_changelog(mod: LocalMod) -> str:
    changelog = mod.directory / "changelog.txt"
    if not changelog.exists():
        return "sin changelog.txt"
    content = changelog.read_text(encoding="utf-8", errors="replace")
    if not re.search(CHANGELOG_VERSION_RE.format(re.escape(mod.version)), content):
        return f"changelog sin entrada para {mod.version}"
    return ""


def git(repo: Path, *arguments: str) -> str | None:
    """Run git in `repo`, or None if it fails (no repo, unknown ref, ...)."""
    completed = subprocess.run(
        ["git", "-C", str(repo), *arguments], capture_output=True, text=True
    )
    return completed.stdout if completed.returncode == 0 else None


def version_in_blob(blob: str | None) -> str | None:
    if not blob:
        return None
    try:
        return json.loads(blob).get("version")
    except ValueError:
        return None


def check_unversioned_changes(mod: LocalMod) -> str:
    """Warn when a mod has been edited but its version was never bumped.

    This is the failure this whole script cannot otherwise catch: a touched mod
    whose version still matches the portal is reported as SKIP and simply never
    reaches anyone, with nothing failing and nothing warning.  So the check is
    here, where the plan is printed, and not left to whoever remembers.

    The reference is the commit that set the *current* version, so the check
    **over-warns but never misses**: any content change after that commit is
    flagged, including work that was committed after the bump and published
    anyway.  Git cannot know when the upload happened.  Confirm a warning with
    `diff-portal-releases.py`, which compares against the published zip itself.

    A bump that is not committed yet counts as done -- that is the normal state
    while a change is still in progress.
    """
    root = git(mod.directory, "rev-parse", "--show-toplevel")
    if not root:
        return ""
    repo = Path(root.strip())

    try:
        relative = mod.directory.resolve().relative_to(repo).as_posix()
    except ValueError:
        return ""

    history = git(repo, "log", "--format=%H", "--", f"{relative}/info.json")
    if history is None:
        return ""
    commits = history.split()

    # Newest first: the bump commit is the oldest of the leading run whose
    # info.json already carries the current version.
    bump = None
    for sha in commits:
        if version_in_blob(git(repo, "show", f"{sha}:{relative}/info.json")) == mod.version:
            bump = sha
        else:
            break

    if bump is None:
        # No commit carries this version: the bump is still uncommitted.
        return ""

    committed = (git(repo, "diff", "--name-only", f"{bump}..HEAD", "--", relative) or "").split()
    pending = [line[3:] for line in (git(repo, "status", "--porcelain", "--", relative) or "").splitlines()]

    changed = {path for path in committed + pending if counts_as_drift(path)}
    if changed:
        return f"{len(changed)} fichero(s) cambiados tras el bump: revisar"
    return ""


def counts_as_drift(path: str) -> bool:
    """¿Ese fichero es contenido publicable, o papeleo de release?

    Se descartan los que no entran en el zip, y ademas `info.json` y
    `changelog.txt`: son el propio registro de la version, y es normal tocarlos
    en commits posteriores al del bump sin que eso sea trabajo sin publicar.
    """
    parts = PurePosixPath(path.strip().strip('"')).parts
    if any(is_excluded(part) for part in parts):
        return False
    return parts[-1] not in ("info.json", "changelog.txt")


def is_excluded(name: str) -> bool:
    from fnmatch import fnmatch

    return any(fnmatch(name, pattern) for pattern in EXCLUDED_NAMES)


def build_mod_zip(mod: LocalMod, zip_root: Path) -> Path:
    """Zip the mod into <name>_<version>.zip with that same folder as its root.

    Written straight from the source tree, with no staging copy: the excluded
    releases alone can be hundreds of MB. Entry paths always use '/', which the
    zip spec and the portal require.
    """
    zip_path = zip_root / f"{mod.package_name}.zip"
    entries: list[tuple[Path, str]] = []

    for path in sorted(mod.directory.rglob("*")):
        relative = path.relative_to(mod.directory)
        if any(is_excluded(part) for part in relative.parts):
            continue
        if path.is_file():
            entries.append((path, f"{mod.package_name}/{relative.as_posix()}"))

    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as archive:
        for source, arcname in entries:
            archive.write(source, arcname)

    return zip_path


def curl_json(arguments: list[str], context: str) -> dict:
    """Run curl and return the parsed JSON, raising on transport or API errors."""
    completed = subprocess.run(
        ["curl", "-sS", *arguments], capture_output=True, text=True
    )
    if completed.returncode != 0:
        raise RuntimeError(
            f"curl fallo ({context}), codigo {completed.returncode}: "
            f"{completed.stderr.strip()}"
        )

    raw = completed.stdout.strip()
    try:
        payload = json.loads(raw)
    except ValueError:
        raise RuntimeError(f"Respuesta no-JSON del portal ({context}): {raw}") from None

    if "error" in payload:
        raise RuntimeError(
            f"Error del portal ({context}): {payload['error']} "
            f"{payload.get('message', '')}".strip()
        )
    return payload


def upload_release(mod: LocalMod, zip_path: Path, api_key: str) -> None:
    """Upload a new version of a mod that already exists on the portal."""
    init = curl_json(
        [
            "-X", "POST",
            "-H", f"Authorization: Bearer {api_key}",
            "-F", f"mod={mod.name}",
            f"{UPLOAD_API}/releases/init_upload",
        ],
        f"init_upload {mod.name}",
    )
    result = curl_json(
        ["-X", "POST", "-F", f"file=@{zip_path}", init["upload_url"]],
        f"upload {mod.name}",
    )
    if not result.get("success"):
        raise RuntimeError(f"El portal no confirmo la subida de {mod.name}.")


def publish_new_mod(mod: LocalMod, zip_path: Path, api_key: str) -> None:
    """Publish a mod that is not on the portal yet."""
    init = curl_json(
        [
            "-X", "POST",
            "-H", f"Authorization: Bearer {api_key}",
            "-F", f"mod={mod.name}",
            f"{UPLOAD_API}/init_publish",
        ],
        f"init_publish {mod.name}",
    )
    result = curl_json(
        [
            "-X", "POST",
            "-F", f"file=@{zip_path}",
            "-F", f"license={NEW_MOD_LICENSE}",
            "-F", f"source_url={NEW_MOD_SOURCE_URL}",
            init["upload_url"],
        ],
        f"publish {mod.name}",
    )
    if not result.get("success"):
        raise RuntimeError(f"El portal no confirmo la publicacion de {mod.name}.")


def print_plan(plan: list[PlanEntry]) -> None:
    header = f"{'Mod':<26} {'Local':<10} {'Portal':<10} {'Accion':<8} Aviso"
    print(header)
    print("-" * len(header))
    for entry in plan:
        print(
            f"{entry.mod.name:<26} {entry.mod.version:<10} "
            f"{entry.portal_version or '-':<10} {entry.action:<8} {entry.warning}"
        )


def read_api_key(path: Path) -> str:
    if not path.exists():
        raise SystemExit(
            f"No existe el archivo de API key: {path}\n"
            "Crea una API key en https://factorio.com/profile con permisos\n"
            '"ModPortal: Upload Mods" y "ModPortal: Publish Mods", y guardala\n'
            "en ese archivo (una sola linea). El archivo esta ignorado por git."
        )
    key = path.read_text(encoding="utf-8").strip()
    if not key:
        raise SystemExit(f"El archivo de API key esta vacio: {path}")
    return key


def parse_arguments(argv: list[str] | None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Publica los mods 5dim_* en el Factorio Mod Portal."
    )
    parser.add_argument("--mods-root", default=str(REPO_ROOT))
    parser.add_argument(
        "--mods",
        action="append",
        default=[],
        help="Solo estos mods (repetible o separado por comas).",
    )
    parser.add_argument("--exclude", action="append", default=[])
    parser.add_argument(
        "--publish",
        action="store_true",
        help="Sube de verdad. Sin este flag no se envia nada al portal.",
    )
    parser.add_argument("--api-key-file", default=str(Path(__file__).with_name(".portal-key")))
    parser.add_argument(
        "--keep-zips",
        metavar="DIR",
        help="Genera los zips en DIR para inspeccionarlos.",
    )
    return parser.parse_args(argv)


def split_list(values: list[str]) -> list[str]:
    return [
        piece.strip() for value in values for piece in value.split(",") if piece.strip()
    ]


def main(argv: list[str] | None = None) -> int:
    args = parse_arguments(argv)

    if args.publish and shutil.which("curl") is None:
        raise SystemExit("Hace falta curl en el PATH para publicar.")

    mods_root = Path(args.mods_root).expanduser().resolve()
    excluded = set(split_list(args.exclude)) | set(ALWAYS_EXCLUDED_MODS)
    mods = discover_mods(mods_root, split_list(args.mods), excluded)

    print(f"Consultando el Mod Portal para {len(mods)} mods...")
    portal_versions = get_portal_versions([mod.name for mod in mods])

    plan: list[PlanEntry] = []
    for mod in mods:
        portal_version = portal_versions.get(mod.name)
        if portal_version is None:
            action = "PUBLISH"
        elif parse_version(mod.version) > parse_version(portal_version):
            action = "UPLOAD"
        else:
            action = "SKIP"

        warning = check_changelog(mod)
        if not warning and action == "SKIP":
            # Solo tiene sentido cuando local y portal coinciden: si el mod se ha
            # tocado, esa version ya publicada no puede reemplazarse y el cambio
            # se quedaria fuera sin que nada fallara.
            warning = check_unversioned_changes(mod)

        plan.append(PlanEntry(mod, portal_version, action, warning))

    print()
    print_plan(plan)
    print()

    for entry in plan:
        if entry.warning:
            print(f"AVISO: {entry.mod.name}: {entry.warning}")

    pending = [entry for entry in plan if entry.action != "SKIP"]

    if not args.publish and not args.keep_zips:
        if pending:
            publishes = sum(1 for e in pending if e.action == "PUBLISH")
            uploads = sum(1 for e in pending if e.action == "UPLOAD")
            print(
                f"\nDry-run: se subirian {len(pending)} mods "
                f"({publishes} PUBLISH, {uploads} UPLOAD). "
                "Ejecuta con --publish para publicar."
            )
        else:
            print("\nDry-run: todos los mods estan al dia en el portal.")
        return 0

    api_key = read_api_key(Path(args.api_key_file).expanduser()) if args.publish else ""

    to_zip = pending if args.publish else plan
    if not to_zip:
        print("Nada que subir: todos los mods estan al dia en el portal.")
        return 0

    keep_zips_dir: Path | None = None
    if args.keep_zips:
        keep_zips_dir = Path(args.keep_zips).expanduser().resolve()
        keep_zips_dir.mkdir(parents=True, exist_ok=True)

    uploaded: list[str] = []
    failed: list[str] = []

    with tempfile.TemporaryDirectory(prefix="5dim-publish-") as temp_root:
        zip_root = Path(temp_root)
        for entry in to_zip:
            mod = entry.mod
            try:
                print(f"Empaquetando {mod.package_name}...")
                zip_path = build_mod_zip(mod, zip_root)

                if keep_zips_dir:
                    shutil.copy2(zip_path, keep_zips_dir / zip_path.name)

                if not args.publish:
                    continue

                if entry.action == "PUBLISH":
                    print(f"Publicando mod nuevo {mod.name}...")
                    publish_new_mod(mod, zip_path, api_key)
                else:
                    print(f"Subiendo {mod.name} {mod.version}...")
                    upload_release(mod, zip_path, api_key)

                print(f"  OK: {mod.name} {mod.version} ({entry.action})")
                uploaded.append(mod.name)
            except (RuntimeError, OSError) as error:
                print(f"  FALLO: {mod.name}: {error}")
                failed.append(mod.name)

    print()
    if keep_zips_dir:
        print(f"Zips conservados en: {keep_zips_dir}")

    if args.publish:
        skipped = len(plan) - len(pending)
        print(
            f"Resumen: {len(uploaded)} subidos, {skipped} saltados, "
            f"{len(failed)} fallidos."
        )
        if failed:
            print(f"Fallidos: {', '.join(failed)}")
            return 1
    else:
        print("Dry-run: zips generados sin publicar. Usa --publish para publicar.")

    return 0


if __name__ == "__main__":
    sys.exit(main())
