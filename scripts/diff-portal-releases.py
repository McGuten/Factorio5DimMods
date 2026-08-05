#!/usr/bin/env python3
"""Compara cada mod local con la version publicada en el Mod Portal.

Responde a la pregunta que `publish-5dim-mods.py` no puede contestar solo: no
"que version pone el portal", sino **que hay dentro** de la release publicada y
en que se diferencia del arbol local.

Hace falta para dos cosas:

- Confirmar o descartar un aviso del dry-run. Ese aviso se calcula con git,
  tomando como referencia el commit que subio la version, asi que sobra avisos
  cuando se siguio trabajando antes de publicar. Esto compara contra el zip
  publicado de verdad, asi que no tiene falsos positivos.
- Saber que entra en una release antes de escribir su changelog. Una version
  publicada puede haberse quedado muy atras: no basta con mirar el ultimo cambio.

Los zips publicados se descargan a un cache (`--cache`) y se reutilizan. Bajarlos
todos son unos 400 MB, asi que conviene filtrar con `--mods`.

Las descargas del portal piden credenciales, que se leen del `player-data.json`
de una instalacion de Factorio (`--factorio-dir`, `$FACTORIO_DIR` o `~/factorio`).
Ese fichero nunca se versiona.

Uso:
    ./scripts/diff-portal-releases.py                     # todos los mods
    ./scripts/diff-portal-releases.py --mods 5dim_core    # solo uno
    ./scripts/diff-portal-releases.py --detail            # lista los ficheros
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import subprocess
import sys
import urllib.request
import zipfile
from fnmatch import fnmatch
from pathlib import Path, PurePosixPath

REPO_ROOT = Path(__file__).resolve().parents[1]
PORTAL_API = "https://mods.factorio.com/api/mods"

# Mismos criterios que publish-5dim-mods.py, para comparar lo que de verdad viaja
# en el zip y no el arbol de trabajo entero.
NEVER_PUBLISHED = ("5dim_decoration", "5dim_dev", "5dim_compatibility")
EXCLUDED_NAMES = ("*.zip", ".git*", ".vscode", ".DS_Store")


def is_excluded(relative: PurePosixPath) -> bool:
    return any(fnmatch(part, pattern) for part in relative.parts for pattern in EXCLUDED_NAMES)


def digests(data: bytes) -> tuple[str, str]:
    """(hash exacto, hash ignorando saltos de linea).

    Los zips publicados desde Windows llevan CRLF y el arbol de WSL LF, asi que
    sin normalizar saldria modificado cada fichero de texto del mod.
    """
    return (
        hashlib.sha1(data).hexdigest(),
        hashlib.sha1(data.replace(b"\r\n", b"\n")).hexdigest(),
    )


def resolve_credentials(explicit: str | None) -> tuple[str, str]:
    candidates = []
    requested = explicit or os.environ.get("FACTORIO_DIR")
    if requested:
        candidates.append(Path(requested).expanduser())
    else:
        candidates += [Path.home() / "factorio", REPO_ROOT.parent]

    for candidate in candidates:
        data = candidate / "player-data.json"
        if not data.exists():
            continue
        payload = json.loads(data.read_text(encoding="utf-8"))
        user, token = payload.get("service-username"), payload.get("service-token")
        if user and token:
            return user, token

    raise SystemExit(
        "No hay credenciales del portal.\n"
        "Se leen del player-data.json de una instalacion de Factorio; probado en: "
        + ", ".join(str(c / "player-data.json") for c in candidates)
        + "\nIndica la instalacion con --factorio-dir DIR o FACTORIO_DIR."
    )


def local_contents(mod_dir: Path) -> dict[str, tuple[str, str]]:
    out = {}
    for path in mod_dir.rglob("*"):
        relative = PurePosixPath(path.relative_to(mod_dir).as_posix())
        if not path.is_file() or is_excluded(relative):
            continue
        out[str(relative)] = digests(path.read_bytes())
    return out


def latest_release(name: str) -> dict | None:
    try:
        with urllib.request.urlopen(f"{PORTAL_API}/{name}/full", timeout=60) as response:
            info = json.load(response)
    except urllib.error.HTTPError as error:
        if error.code == 404:
            return None
        raise
    releases = info.get("releases") or []
    return releases[-1] if releases else None


def portal_contents(name: str, release: dict, cache: Path,
                    credentials: tuple[str, str]) -> dict[str, tuple[str, str]]:
    cache.mkdir(parents=True, exist_ok=True)
    zip_path = cache / f"{name}_{release['version']}.zip"

    if not zip_path.exists():
        user, token = credentials
        url = (f"https://mods.factorio.com{release['download_url']}"
               f"?username={user}&token={token}")
        subprocess.run(["curl", "-sSL", "--fail", "-o", str(zip_path), url], check=True)

    out = {}
    with zipfile.ZipFile(zip_path) as archive:
        for item in archive.infolist():
            if item.is_dir():
                continue
            # La raiz del zip es <nombre>_<version>/, que aqui sobra.
            relative = PurePosixPath(*PurePosixPath(item.filename).parts[1:])
            if is_excluded(relative):
                continue
            out[str(relative)] = digests(archive.read(item))
    return out


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--mods", help="solo estos mods (separados por comas)")
    parser.add_argument("--factorio-dir", metavar="DIR",
                        help="instalacion de la que leer player-data.json")
    parser.add_argument("--cache", default=None,
                        help="donde guardar los zips descargados (por defecto un temporal)")
    parser.add_argument("--detail", action="store_true",
                        help="lista los ficheros que cambian, no solo el recuento")
    arguments = parser.parse_args()

    wanted = {m.strip() for m in arguments.mods.split(",")} if arguments.mods else None
    cache = Path(arguments.cache).expanduser() if arguments.cache \
        else Path(os.environ.get("TMPDIR", "/tmp")) / "5dim-portal-releases"
    credentials = resolve_credentials(arguments.factorio_dir)

    print(f"{'Mod':<26} {'Portal':<10} {'Local':<10} Veredicto")
    print("-" * 78)

    differing = []
    for info_path in sorted(REPO_ROOT.glob("5dim_*/info.json")):
        mod_dir = info_path.parent
        info = json.loads(info_path.read_text(encoding="utf-8-sig"))
        name, version = info["name"], info["version"]
        if wanted and name not in wanted:
            continue

        if name in NEVER_PUBLISHED:
            print(f"{name:<26} {'-':<10} {version:<10} no se publica nunca")
            continue

        release = latest_release(name)
        if release is None:
            print(f"{name:<26} {'-':<10} {version:<10} NO PUBLICADO")
            continue

        remote = portal_contents(name, release, cache, credentials)
        local = local_contents(mod_dir)

        added = sorted(set(local) - set(remote))
        removed = sorted(set(remote) - set(local))
        shared = set(local) & set(remote)
        modified = sorted(f for f in shared if local[f][1] != remote[f][1])
        eol_only = sorted(f for f in shared
                          if local[f][1] == remote[f][1] and local[f][0] != remote[f][0])

        if added or removed or modified:
            verdict = f"CAMBIOS  +{len(added)} -{len(removed)} ~{len(modified)}"
            differing.append((name, release["version"], version, added, removed, modified))
        elif eol_only:
            verdict = "identico (solo saltos de linea)"
        else:
            verdict = "identico"

        print(f"{name:<26} {release['version']:<10} {version:<10} {verdict}")

    if arguments.detail and differing:
        for name, portal_version, version, added, removed, modified in differing:
            print()
            print(f"### {name}  (portal {portal_version} / local {version})")
            for label, files in (("anadidos", added), ("borrados", removed),
                                 ("modificados", modified)):
                if files:
                    print(f"  {label} ({len(files)}):")
                    for path in files:
                        print(f"    {path}")

    print()
    if differing:
        print(f"{len(differing)} mod(s) difieren de lo publicado. Si alguno no lleva "
              "version nueva en el plan de publicacion, le falta el bump.")
    else:
        print("Ningun mod difiere de lo publicado.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
