#!/usr/bin/env bash
set -euo pipefail

FONT_NAME="JetBrainsMono"
FONT_VERSION="v3.5.1"
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/${FONT_NAME}.zip"

TMP_DIR="$(mktemp -d)"

# Detectar directorio de fuentes según el sistema operativo del host
if [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    FONT_DIR="$HOME/.local/share/fonts/${FONT_NAME}"
else
    echo "❌ Sistema operativo no soportado por este script: $OSTYPE"
    exit 1
fi

echo "⬇️  Descargando ${FONT_NAME} Nerd Font (${FONT_VERSION})..."
curl -fLo "${TMP_DIR}/${FONT_NAME}.zip" "${DOWNLOAD_URL}"

echo "📦 Extrayendo fuentes en ${FONT_DIR}..."
mkdir -p "${FONT_DIR}"
unzip -oq "${TMP_DIR}/${FONT_NAME}.zip" -d "${FONT_DIR}"

# Limpiar archivos de licencia o readme que vienen en el zip
rm -f "${FONT_DIR}"/*.md "${FONT_DIR}"/*.txt

# Actualizar caché de fuentes en Linux
if [[ "$OSTYPE" == "linux-gnu"* ]] && command -v fc-cache >/dev/null 2>&1; then
    echo "🔄 Actualizando caché de fuentes del sistema..."
    fc-cache -fv "${FONT_DIR}" >/dev/null
fi

# Limpiar temporal
rm -rf "${TMP_DIR}"

echo "✅ ¡${FONT_NAME} Nerd Font instalada correctamente!"
