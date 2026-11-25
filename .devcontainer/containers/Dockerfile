FROM mcr.microsoft.com/devcontainers/base:ubuntu26.04

# 1. Instalar dependencias base, gnupg, zsh y fzf
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
    curl git gnupg2 ca-certificates docker-cli zsh fzf \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# 2. Instalar Starship en /usr/local/bin
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y -b /usr/local/bin

# 3. Instalar plugins ligeros de Zsh a nivel de sistema
RUN mkdir -p /usr/share/zsh-plugins \
    && git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git /usr/share/zsh-plugins/zsh-autosuggestions \
    && git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/zsh-plugins/zsh-syntax-highlighting

# 4. Inyectar políticas de seguridad inmutables desde settings-files/
RUN mkdir -p /etc/claude-code
COPY settings-files/managed-settings.json /etc/claude-code/managed-settings.json
RUN chown root:root /etc/claude-code/managed-settings.json \
    && chmod 644 /etc/claude-code/managed-settings.json

# 5. Configurar Zsh como shell predeterminado para vscode
RUN chsh -s /usr/bin/zsh vscode

USER vscode

# Pre-crear directorios de volúmenes con dueño vscode:vscode para que Docker herede los permisos
RUN mkdir -p /home/vscode/.config \
    /home/vscode/.claude \
    /home/vscode/.local/share/mise \
    /home/vscode/.vscode-server

# 6. Copiar configuración limpia de Zsh y Starship al home de vscode
RUN mkdir -p /home/vscode/.config
COPY --chown=vscode:vscode settings-files/.zshrc /home/vscode/.zshrc
COPY --chown=vscode:vscode settings-files/starship.toml /home/vscode/.config/starship.toml