#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Bootstrapping Claude Studio con mise..."

export PATH="$HOME/.local/share/mise/shims:$HOME/.local/bin:$PATH"

# 1. Confiar en mise.toml e instalar todas las herramientas (incluyendo herdr)
mise trust /claude-studio/workspace/mise.toml
mise install
mise reshim

# 2. Instalar el hook de integración de Herdr para Claude Code
mkdir -p "$HOME/.claude"
if command -v herdr >/dev/null 2>&1; then
  herdr integration install claude || true
fi

echo "✅ Herramientas instaladas y configuradas:"
mise list
