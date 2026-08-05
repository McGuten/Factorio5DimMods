#!/usr/bin/env bash
#
# Lanza el Factorio **nativo de Windows** desde WSL, con los mods de este repo.
#
# Por que existe: el Factorio de WSL renderiza por software (llvmpipe, sin GPU),
# asi que sirve para validar que los mods cargan pero no para jugar ni para
# revisar arte en movimiento. La interop de WSL permite ejecutar el .exe, que si
# usa la GPU. Este script sincroniza los mods y lo arranca.
#
# Uso:
#   ./scripts/run-factorio-windows.sh [--factorio-dir DIR] [--no-sync]
#                                     [--sync-only] [--quiet] [-- ARGS...]
#
# Instalacion destino, por orden de prioridad:
#   1. --factorio-dir DIR
#   2. $WIN_FACTORIO_DIR
#   3. scripts/.factorio-windows-dir (una linea con la ruta; no se versiona)
#   4. Autodeteccion bajo /mnt/<unidad>/
#
# Cualquier argumento tras `--` se pasa tal cual al juego, por ejemplo:
#   ./scripts/run-factorio-windows.sh -- --load-game mi-partida

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
DIR_FILE="$REPO_ROOT/scripts/.factorio-windows-dir"
FACTORIO_DIR="${WIN_FACTORIO_DIR:-}"
SYNC=1
LAUNCH=1
QUIET=0
PASSTHROUGH=()

# Mods que no se sincronizan como habilitados, los mismos que quedan fuera de las
# suites de validate-factorio-profiles.py y del enlazado de WSL:
#   - 5dim_compatibility solo actua sobre mods de terceros.
#   - 5dim_decoration sigue en sintaxis de Factorio 1.x (recetas con `result` en
#     vez de `results`), asi que sus recetas quedan sin resultado y el mod
#     `recycler` de Space Age aborta la carga al generar su receta de reciclaje.
DISABLED_MODS=(5dim_compatibility 5dim_decoration)

usage() {
    awk 'NR > 1 { if ($0 !~ /^#/) exit; sub(/^# ?/, ""); print }' "${BASH_SOURCE[0]}"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --factorio-dir)
            FACTORIO_DIR="${2:?--factorio-dir necesita una ruta}"
            shift 2
            ;;
        --no-sync)
            SYNC=0
            shift
            ;;
        --sync-only)
            LAUNCH=0
            shift
            ;;
        --quiet)
            QUIET=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            PASSTHROUGH+=("$@")
            break
            ;;
        *)
            echo "Argumento desconocido: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
done

log() {
    [[ $QUIET -eq 1 ]] || echo "$@"
}

is_install() {
    [[ -x "$1/bin/x64/factorio.exe" || -f "$1/bin/x64/factorio.exe" ]]
}

# Autodeteccion: se buscan instalaciones bajo las unidades montadas en /mnt. Se
# usan globs en vez de `find` para no recorrer discos enteros.
detect_installs() {
    local candidate
    shopt -s nullglob
    for candidate in /mnt/*/*/bin/x64/factorio.exe /mnt/*/*/*/bin/x64/factorio.exe; do
        printf '%s\n' "${candidate%/bin/x64/factorio.exe}"
    done
    shopt -u nullglob
}

if [[ -z "$FACTORIO_DIR" && -f "$DIR_FILE" ]]; then
    FACTORIO_DIR="$(head -n 1 -- "$DIR_FILE" | tr -d '\r')"
fi

if [[ -z "$FACTORIO_DIR" ]]; then
    mapfile -t FOUND < <(detect_installs)
    if [[ ${#FOUND[@]} -eq 1 ]]; then
        FACTORIO_DIR="${FOUND[0]}"
        log "Instalacion detectada: $FACTORIO_DIR"
    elif [[ ${#FOUND[@]} -eq 0 ]]; then
        echo "No se encuentra ningun Factorio de Windows bajo /mnt/." >&2
        echo "Indicalo con --factorio-dir DIR, la variable WIN_FACTORIO_DIR," >&2
        echo "o escribiendo la ruta en $DIR_FILE" >&2
        exit 1
    else
        echo "Hay varias instalaciones de Factorio en Windows:" >&2
        printf '  %s\n' "${FOUND[@]}" >&2
        echo "Elige una con --factorio-dir DIR o fijala en $DIR_FILE" >&2
        exit 1
    fi
fi

if ! is_install "$FACTORIO_DIR"; then
    echo "No hay un Factorio de Windows en: $FACTORIO_DIR" >&2
    echo "Falta bin/x64/factorio.exe" >&2
    exit 1
fi

MODS_DIR="$FACTORIO_DIR/mods"
mkdir -p "$MODS_DIR"

# --- Sincronizacion --------------------------------------------------------
#
# Se copia **carpeta a carpeta**, nunca el mods/ entero: ahi conviven los zips de
# mods externos, mod-list.json y mod-settings.dat, que no son del repo y no se
# deben tocar. Dentro de cada mod si se borra lo que sobra (`--delete`), que es
# imprescindible: los cambios de arte eliminan ficheros, y sin borrarlos el mod
# se queda con PNG viejos y con un peso que no corresponde.
if [[ $SYNC -eq 1 ]]; then
    synced=0
    for info in "$REPO_ROOT"/5dim_*/info.json; do
        mod_dir="$(dirname -- "$info")"
        mod="$(basename -- "$mod_dir")"
        rsync -a --delete --exclude '.git' -- "$mod_dir/" "$MODS_DIR/$mod/"
        synced=$((synced + 1))
    done

    if [[ $synced -eq 0 ]]; then
        echo "No se ha encontrado ningun 5dim_*/info.json en $REPO_ROOT" >&2
        exit 1
    fi
    log "Sincronizados $synced mods en $MODS_DIR"

    # mod-list.json es del juego, no del repo, asi que solo se corrigen las dos
    # entradas que impiden cargar. El resto de la seleccion es del usuario.
    LIST="$MODS_DIR/mod-list.json"
    if [[ -f "$LIST" ]]; then
        python3 - "$LIST" "${DISABLED_MODS[@]}" <<'PY'
import json
import sys

path, *disabled = sys.argv[1:]
with open(path, encoding="utf-8") as handle:
    data = json.load(handle)

changed = []
for entry in data.get("mods", []):
    if entry.get("name") in disabled and entry.get("enabled"):
        entry["enabled"] = False
        changed.append(entry["name"])

if changed:
    with open(path, "w", encoding="utf-8") as handle:
        json.dump(data, handle, indent=2)
        handle.write("\n")
    print("  desactivados en mod-list.json: " + ", ".join(changed))
PY
    fi
fi

[[ $LAUNCH -eq 1 ]] || exit 0

# --- Arranque --------------------------------------------------------------
#
# Se lanza desde el propio directorio de la instalacion: es una ruta de /mnt, que
# Windows ve como una unidad normal, y asi el proceso no arranca con un
# directorio de trabajo de WSL (que en Windows seria una UNC).
log "Arrancando $FACTORIO_DIR/bin/x64/factorio.exe"
cd -- "$FACTORIO_DIR"
exec ./bin/x64/factorio.exe "${PASSTHROUGH[@]}"
