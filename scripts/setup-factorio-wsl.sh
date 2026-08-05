#!/usr/bin/env bash
#
# Instala el Factorio de pruebas de WSL a partir del .tar.xz oficial de Linux y
# lo deja listo para cargar los mods de este repo. La instalacion vive FUERA del
# repo y es autocontenida: config, saves y mods cuelgan de ella.
#
# Uso:
#   ./scripts/setup-factorio-wsl.sh [--factorio-dir DIR] [--archive FICHERO]
#                                   [--external-mods DIR] [--player-data RUTA]
#                                   [--keep-archive] [--no-player-data] [--force]
#
# Por defecto instala en $FACTORIO_DIR o $HOME/factorio, usa el unico
# factorio-*.tar.xz de la raiz del repo y lo borra al terminar bien. Los mods
# externos se toman de $EXTERNAL_MODS_DIR ($HOME/factorio-mods-externos).
#
# El login (player-data.json) no se busca en ninguna ruta fija: se indica con
# --player-data o con la variable de entorno FACTORIO_PLAYER_DATA.

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
FACTORIO_DIR="${FACTORIO_DIR:-$HOME/factorio}"
EXTERNAL_MODS_DIR="${EXTERNAL_MODS_DIR:-$HOME/factorio-mods-externos}"
ARCHIVE=""
# Login de Factorio. Es un dato privado: no se versiona ninguna ruta concreta,
# se pasa con --player-data o con la variable FACTORIO_PLAYER_DATA.
PLAYER_DATA_SOURCE="${FACTORIO_PLAYER_DATA:-}"
KEEP_ARCHIVE=0
COPY_PLAYER_DATA=1
FORCE=0
REQUIRED_GB=15

usage() {
    awk 'NR > 1 { if ($0 !~ /^#/) exit; sub(/^# ?/, ""); print }' "${BASH_SOURCE[0]}"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --factorio-dir)
            FACTORIO_DIR="${2:?--factorio-dir necesita una ruta}"
            shift 2
            ;;
        --archive)
            ARCHIVE="${2:?--archive necesita una ruta}"
            shift 2
            ;;
        --player-data)
            PLAYER_DATA_SOURCE="${2:?--player-data necesita una ruta}"
            shift 2
            ;;
        --external-mods)
            EXTERNAL_MODS_DIR="${2:?--external-mods necesita una ruta}"
            shift 2
            ;;
        --keep-archive)
            KEEP_ARCHIVE=1
            shift
            ;;
        --no-player-data)
            COPY_PLAYER_DATA=0
            shift
            ;;
        --force)
            FORCE=1
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

step() {
    echo
    echo "==> $*"
}

INSTALL_PARENT="$(dirname -- "$FACTORIO_DIR")"

if [[ -z "$ARCHIVE" ]]; then
    mapfile -t candidates < <(find "$REPO_ROOT" -maxdepth 1 -name 'factorio-*.tar.xz' -type f | sort)
    if [[ ${#candidates[@]} -eq 0 ]]; then
        if [[ -x "$FACTORIO_DIR/bin/x64/factorio" ]]; then
            echo "No hay tarball, pero ya existe una instalacion en $FACTORIO_DIR."
            echo "Se continua sin extraer."
        else
            echo "No se ha encontrado ningun factorio-*.tar.xz en $REPO_ROOT." >&2
            echo "Descargalo de https://factorio.com/download y pasalo con --archive." >&2
            exit 1
        fi
    elif [[ ${#candidates[@]} -gt 1 ]]; then
        echo "Hay varios tarballs en $REPO_ROOT; elige uno con --archive:" >&2
        printf '  %s\n' "${candidates[@]}" >&2
        exit 1
    else
        ARCHIVE="${candidates[0]}"
    fi
fi

step "Comprobaciones previas"
echo "  repo:      $REPO_ROOT"
echo "  install:   $FACTORIO_DIR"
echo "  tarball:   ${ARCHIVE:-<ninguno>}"

mkdir -p "$INSTALL_PARENT"
available_gb=$(df -BG --output=avail "$INSTALL_PARENT" | tail -1 | tr -dc '0-9')
if [[ -n "$available_gb" && "$available_gb" -lt "$REQUIRED_GB" ]]; then
    echo "Espacio insuficiente en $INSTALL_PARENT: ${available_gb}G libres, hacen falta ${REQUIRED_GB}G." >&2
    exit 1
fi
echo "  espacio:   ${available_gb}G libres en $INSTALL_PARENT"

extracted=0
if [[ -n "$ARCHIVE" ]]; then
    if [[ ! -f "$ARCHIVE" ]]; then
        echo "El tarball no existe: $ARCHIVE" >&2
        exit 1
    fi

    if [[ -e "$FACTORIO_DIR" && $FORCE -eq 0 ]]; then
        echo
        echo "Ya existe $FACTORIO_DIR: se omite la extraccion (usa --force para reinstalar)."
    else
        step "Extrayendo $(basename -- "$ARCHIVE") (unos minutos)"
        staging="$(mktemp -d "$INSTALL_PARENT/.factorio-extract-XXXXXX")"
        # shellcheck disable=SC2064
        trap "rm -rf -- '$staging'" EXIT

        # El tar oficial trae ya el prefijo factorio/; -T0 aprovecha los cores.
        tar --use-compress-program='xz -T0 -d' -xf "$ARCHIVE" -C "$staging"

        if [[ ! -d "$staging/factorio" ]]; then
            echo "El tarball no contiene el directorio factorio/ esperado." >&2
            exit 1
        fi

        if [[ -e "$FACTORIO_DIR" ]]; then
            backup="$FACTORIO_DIR.old.$(date +%Y%m%d-%H%M%S)"
            echo "  moviendo la instalacion anterior a $backup"
            mv -- "$FACTORIO_DIR" "$backup"
        fi

        mv -- "$staging/factorio" "$FACTORIO_DIR"
        rm -rf -- "$staging"
        trap - EXIT
        extracted=1
    fi
fi

FACTORIO_BIN="$FACTORIO_DIR/bin/x64/factorio"

step "Verificando el binario"
if [[ ! -x "$FACTORIO_BIN" ]]; then
    echo "No existe o no es ejecutable: $FACTORIO_BIN" >&2
    exit 1
fi

if ! version_output="$("$FACTORIO_BIN" --version 2>&1)"; then
    echo "$version_output" >&2
    echo >&2
    echo "El binario no arranca. Si se queja de librerias compartidas, mira cuales faltan con:" >&2
    echo "  ldd $FACTORIO_BIN | grep 'not found'" >&2
    echo "y instalalas con apt (no se instala nada automaticamente)." >&2
    exit 1
fi
echo "$version_output" | sed 's/^/  /'

if [[ $COPY_PLAYER_DATA -eq 1 && -n "$PLAYER_DATA_SOURCE" ]]; then
    step "Credenciales (player-data.json)"
    if [[ -f "$PLAYER_DATA_SOURCE" ]]; then
        if [[ -f "$FACTORIO_DIR/player-data.json" && $FORCE -eq 0 ]]; then
            echo "  ya existe $FACTORIO_DIR/player-data.json, no se sobreescribe"
        else
            cp -- "$PLAYER_DATA_SOURCE" "$FACTORIO_DIR/player-data.json"
            echo "  copiado desde $PLAYER_DATA_SOURCE"
        fi
    else
        echo "  aviso: no se encuentra $PLAYER_DATA_SOURCE; tendras que iniciar sesion en el juego" >&2
        echo "  (sin login valido el DLC space-age puede no cargar)" >&2
    fi
elif [[ $COPY_PLAYER_DATA -eq 1 && ! -f "$FACTORIO_DIR/player-data.json" ]]; then
    step "Credenciales (player-data.json)"
    echo "  no se ha indicado ningun player-data.json de origen"
    echo "  usa --player-data <ruta> (o FACTORIO_PLAYER_DATA) para reutilizar un login existente,"
    echo "  o inicia sesion la primera vez desde el propio juego"
fi

step "Preparando mods/"
mkdir -p "$FACTORIO_DIR/mods"

# Semillas opcionales de la raiz del repo: la lista de mods activos y los ajustes.
for seed in mod-list.json mod-settings.dat; do
    if [[ -f "$REPO_ROOT/$seed" && ! -f "$FACTORIO_DIR/mods/$seed" ]]; then
        cp -- "$REPO_ROOT/$seed" "$FACTORIO_DIR/mods/$seed"
        echo "  semilla      $seed"
    fi
done

# Los mods externos (dependencias duras como bobinserters) viven fuera del repo.
mkdir -p "$EXTERNAL_MODS_DIR"

"$REPO_ROOT/scripts/link-5dim-mods.sh" \
    --factorio-dir "$FACTORIO_DIR" \
    --external-mods "$EXTERNAL_MODS_DIR"

if [[ -n "$ARCHIVE" && -f "$ARCHIVE" ]]; then
    step "Tarball"
    if [[ $KEEP_ARCHIVE -eq 1 ]]; then
        echo "  se conserva $ARCHIVE (--keep-archive)"
    elif [[ $extracted -eq 1 ]]; then
        rm -- "$ARCHIVE"
        echo "  borrado $ARCHIVE (la instalacion ya esta verificada)"
    else
        echo "  no se ha extraido nada en esta ejecucion, se conserva $ARCHIVE"
    fi
fi

echo
echo "Listo. Arranca el juego con:"
echo "  ./scripts/run-factorio-wsl.sh"
