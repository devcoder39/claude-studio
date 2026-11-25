#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Bootstrapping Claude Studio con mise..."

export PATH="$HOME/.local/share/mise/shims:$HOME/.local/bin:$PATH"

# 1. Configurar gopass apuntando al montaje fresco en /home/vscode/.gopass-vault
mkdir -p "$HOME/.config/gopass"
printf "[mounts]\n\tpath = /home/vscode/.gopass-vault\n" > "$HOME/.config/gopass/config"

mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
rm -f "$HOME/.gnupg"/S.gpg-agent*
for item in pubring.kbx pubring.gpg public-keys.d private-keys-v1.d trustdb.gpg; do
  if [ -e "/mnt/host-gnupg/$item" ]; then
    ln -sfn "/mnt/host-gnupg/$item" "$HOME/.gnupg/$item"
  fi
done

# Configurar pinentry de terminal y desactivar scdaemon (smartcards)
cat << 'EOF' > "$HOME/.gnupg/gpg-agent.conf"
pinentry-program /usr/bin/pinentry-curses
allow-loopback-pinentry
disable-scdaemon
default-cache-ttl 28800
max-cache-ttl 86400
EOF

gpgconf --kill gpg-agent || true

# 2. Confiar en mise.toml e instalar todas las herramientas
mise trust /claude-studio/workspace/mise.toml
mise install
mise reshim

# 3. Instalar el hook de integración de Herdr para Claude Code
mkdir -p "$HOME/.claude"
if command -v herdr >/dev/null 2>&1; then
  herdr integration install claude || true
fi

echo "✅ Herramientas instaladas y configuradas:"
mise list

