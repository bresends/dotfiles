# ============================================================================
# Oh My Zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

CASE_SENSITIVE="true"

plugins=(
  git
  zsh-autosuggestions
  F-Sy-H
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# ============================================================================
# Completion & Styling
# ============================================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# ============================================================================
# Key Bindings
# ============================================================================
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[Z' autosuggest-accept  # shift + tab

# ============================================================================
# Aliases
# ============================================================================
alias ls="ls --color=auto -lh"
alias lsa='ls --color=auto -lah'
alias vim='nvim'
alias cd="echo 'Use Z to go to'"
alias obs='z /mnt/c/Users/bruno/obsidian'
alias lg='lazygit'

# ============================================================================
# External Tool Integrations
# ============================================================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# ============================================================================
# Development Tools
# ============================================================================

# Mise
eval "$($HOME/.local/bin/mise activate zsh)"

# Laravel
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# Fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
