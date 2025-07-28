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
alias cd="echo 'Use Z to go to'"
alias obs='cd /mnt/c/Users/bruno/obsidian'
alias lg='lazygit'

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

eval "$(/home/bruno/.local/bin/mise activate zsh)" # added by https://mise.run/zsh
