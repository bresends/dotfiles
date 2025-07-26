# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

CASE_SENSITIVE="true"

plugins=(
  git
  zsh-autosuggestions
  F-Sy-H
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ls="ls --color=auto -lh"
alias lsa='ls --color=auto -lah'
alias vim='nvim'
alias a="php artisan"

# Bindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Laravel
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Rust
source "$HOME/.cargo/env"

# Fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

. "$HOME/.local/bin/env"

# bun completions
[ -s "/home/bruno/.bun/_bun" ] && source "/home/bruno/.bun/_bun"

# Auto-start tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

eval "$(starship init zsh)"
