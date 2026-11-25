# Historial y caché en /tmp (compatible con contenedor read_only)
export HISTFILE="/tmp/.zsh_history"
export HISTSIZE=5000
export SAVEHIST=5000
setopt HIST_IGNORE_DUPS SHARE_HISTORY

# Autocompletado nativo de Zsh apuntando a /tmp
autoload -Uz compinit
compinit -d "/tmp/.zcompdump-${HOST}-${ZSH_VERSION}"

# Activar mise (inyecta node, gopass y claude en el PATH)
export MISE_CACHE_DIR="/tmp/.mise-cache"
eval "$(mise activate zsh)"

# Búsqueda difusa fzf (Ctrl+R)
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

# Plugins rápidos de Zsh
source /usr/share/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Caché de Starship en /tmp e inicialización del prompt
export STARSHIP_CACHE="/tmp/.starship-cache"
eval "$(starship init zsh)"

# Alias prácticos para Claude Studio
alias cc="claude"
alias ccr="claude --resume"
