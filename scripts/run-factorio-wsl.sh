#!/usr/bin/env bash
#
# Arranca el Factorio de pruebas de WSL con los mods de este repo, usando la GUI
# a traves de WSLg. Antes de lanzar refresca los symlinks de mods/.
#
# Uso:
#   ./scripts/run-factorio-wsl.sh [--factorio-dir DIR] [--no-link] [-- ARGS...]
#
# Cualquier argumento extra se pasa tal cual al binario, por ejemplo:
#   ./scripts/run-factorio-wsl.sh --load-game mi-partida
#   ./scripts/run-factorio-wsl.sh --create /tmp/prueba.zip

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
FACTORIO_DIR="${FACTORIO_DIR:-$HOME/factorio}"
LINK=1
PASSTHROUGH=()

usage() {
    awk 'NR > 1 { if ($0 !~ /^#/) exit; sub(/^# ?/, ""); print }' "${BASH_SOURCE[0]}"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --factorio-dir)
            FACTORIO_DIR="${2:?--factorio-dir necesita una ruta}"
            shift 2
            ;;
        --no-link)
            LINK=0
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
            PASSTHROUGH+=("$1")
            shift
            ;;
    esac
done

FACTORIO_BIN="$FACTORIO_DIR/bin/x64/factorio"

if [[ ! -x "$FACTORIO_BIN" ]]; then
    echo "No hay instalacion de Factorio en $FACTORIO_DIR." >&2
    echo "Ejecuta primero ./scripts/setup-factorio-wsl.sh" >&2
    exit 1
fi

if [[ $LINK -eq 1 ]]; then
    "$REPO_ROOT/scripts/link-5dim-mods.sh" --factorio-dir "$FACTORIO_DIR" --quiet
fi

if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" ]]; then
    echo "No hay DISPLAY ni WAYLAND_DISPLAY: WSLg no esta disponible en esta sesion." >&2
    echo "Abre una terminal WSL normal (no una sesion sin entorno grafico) o exporta DISPLAY=:0." >&2
    exit 1
fi

echo "Lanzando $FACTORIO_BIN"
echo "  mods:    $FACTORIO_DIR/mods"
echo "  log:     $FACTORIO_DIR/factorio-current.log"
if [[ ${#PASSTHROUGH[@]} -gt 0 ]]; then
    echo "  args:    ${PASSTHROUGH[*]}"
fi

exec "$FACTORIO_BIN" "${PASSTHROUGH[@]}"
