#!/usr/bin/env bash
#
# Enlaza los mods 5dim_* de este repo dentro de la carpeta mods/ del Factorio de
# pruebas de WSL, junto con los zips de mods externos. No copia nada: crea un
# symlink por mod, asi que cualquier edicion en el repo se ve al reiniciar.
#
# Uso:
#   ./scripts/link-5dim-mods.sh [--factorio-dir DIR] [--external-mods DIR]
#                               [--no-external] [--no-prune] [--quiet]
#
# Destino: $FACTORIO_DIR (por defecto $HOME/factorio).
# Mods externos: $EXTERNAL_MODS_DIR (por defecto $HOME/factorio-mods-externos).

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
FACTORIO_DIR="${FACTORIO_DIR:-$HOME/factorio}"
EXTERNAL_MODS_DIR="${EXTERNAL_MODS_DIR:-$HOME/factorio-mods-externos}"
PRUNE=1
QUIET=0
LINK_EXTERNAL=1

usage() {
    awk 'NR > 1 { if ($0 !~ /^#/) exit; sub(/^# ?/, ""); print }' "${BASH_SOURCE[0]}"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --factorio-dir)
            FACTORIO_DIR="${2:?--factorio-dir necesita una ruta}"
            shift 2
            ;;
        --external-mods)
            EXTERNAL_MODS_DIR="${2:?--external-mods necesita una ruta}"
            shift 2
            ;;
        --no-external)
            LINK_EXTERNAL=0
            shift
            ;;
        --no-prune)
            PRUNE=0
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

MODS_DIR="$FACTORIO_DIR/mods"

if [[ ! -d "$FACTORIO_DIR" ]]; then
    echo "No existe la instalacion de Factorio en: $FACTORIO_DIR" >&2
    echo "Ejecuta primero ./scripts/setup-factorio-wsl.sh" >&2
    exit 1
fi

mkdir -p "$MODS_DIR"

# Mods que no se enlazan al Factorio de pruebas, los mismos que quedan fuera de
# las suites de validate-factorio-profiles.py:
#   - 5dim_compatibility solo actua sobre mods de terceros que aqui no estan.
#   - 5dim_decoration sigue en sintaxis de Factorio 1.x (recetas con `result` en
#     vez de `results`), asi que sus recetas quedan sin resultado y el mod
#     `recycler` de Space Age aborta la carga al generar su receta de reciclaje.
EXCLUDED_MODS="5dim_compatibility 5dim_decoration"

# Cada mod se declara en su info.json; el nombre de la carpeta destino tiene que
# ser el "name" del mod, que no siempre coincide con el de la carpeta del repo.
mapfile -t MOD_ENTRIES < <(
    python3 - "$REPO_ROOT" "$EXCLUDED_MODS" <<'PY'
import json
import pathlib
import sys

repo = pathlib.Path(sys.argv[1])
excluded = set(sys.argv[2].split())
for info_path in sorted(repo.glob("5dim_*/info.json")):
    if info_path.parent.name in excluded:
        continue
    try:
        info = json.loads(info_path.read_text(encoding="utf-8-sig"))
    except (OSError, ValueError) as error:
        print(f"!\t{info_path.parent.name}\t{error}")
        continue
    name = info.get("name")
    if not name:
        print(f"!\t{info_path.parent.name}\tinfo.json sin campo name")
        continue
    print(f"=\t{info_path.parent.name}\t{name}")
PY
)

if [[ ${#MOD_ENTRIES[@]} -eq 0 ]]; then
    echo "No se ha encontrado ningun 5dim_*/info.json en $REPO_ROOT" >&2
    exit 1
fi

declare -A EXPECTED=()
created=0
updated=0
skipped=0
problems=0

for entry in "${MOD_ENTRIES[@]}"; do
    IFS=$'\t' read -r kind dir name <<<"$entry"

    if [[ "$kind" == "!" ]]; then
        echo "  aviso: $dir ignorado ($name)" >&2
        problems=$((problems + 1))
        continue
    fi

    EXPECTED["$name"]=1
    target="$REPO_ROOT/$dir"
    link="$MODS_DIR/$name"

    if [[ -L "$link" ]]; then
        current="$(readlink -- "$link")"
        if [[ "$current" == "$target" ]]; then
            skipped=$((skipped + 1))
            continue
        fi
        ln -sfn -- "$target" "$link"
        log "  actualizado  $name -> $target"
        updated=$((updated + 1))
        continue
    fi

    if [[ -e "$link" ]]; then
        # Hay un directorio o zip real con ese nombre: no se toca nunca.
        echo "  aviso: $link existe y no es un symlink, se deja como esta" >&2
        problems=$((problems + 1))
        continue
    fi

    ln -s -- "$target" "$link"
    log "  enlazado     $name -> $target"
    created=$((created + 1))
done

# Mods externos (dependencias duras como bobinserters): viven fuera del repo,
# como zips ya empaquetados, y se enlazan igual que los 5dim_*.
if [[ $LINK_EXTERNAL -eq 1 && -d "$EXTERNAL_MODS_DIR" ]]; then
    shopt -s nullglob
    for external in "$EXTERNAL_MODS_DIR"/*.zip; do
        base="$(basename -- "$external")"
        EXPECTED["$base"]=1
        link="$MODS_DIR/$base"

        if [[ -L "$link" ]]; then
            if [[ "$(readlink -- "$link")" == "$external" ]]; then
                skipped=$((skipped + 1))
                continue
            fi
            ln -sfn -- "$external" "$link"
            log "  actualizado  $base -> $external"
            updated=$((updated + 1))
            continue
        fi

        if [[ -e "$link" ]]; then
            echo "  aviso: $link ya existe como fichero real, se deja como esta" >&2
            problems=$((problems + 1))
            continue
        fi

        ln -s -- "$external" "$link"
        log "  externo      $base -> $external"
        created=$((created + 1))
    done
    shopt -u nullglob
fi

pruned=0
if [[ $PRUNE -eq 1 ]]; then
    while IFS= read -r -d '' link; do
        name="$(basename -- "$link")"
        if [[ -n "${EXPECTED[$name]:-}" && -e "$link" ]]; then
            continue
        fi
        # Solo se borran symlinks: rotos, o de mods que ya no estan en el repo.
        rm -- "$link"
        log "  eliminado    $name (enlace obsoleto o roto)"
        pruned=$((pruned + 1))
    done < <(find "$MODS_DIR" -maxdepth 1 -type l -print0)
fi

log "Mods enlazados en $MODS_DIR: ${#EXPECTED[@]} (nuevos $created, actualizados $updated, sin cambios $skipped, eliminados $pruned)"

if [[ $problems -gt 0 ]]; then
    echo "Terminado con $problems aviso(s)." >&2
    exit 1
fi
