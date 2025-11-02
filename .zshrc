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
# Key Bindings (zle -al to show all)
# ============================================================================
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey "^[l" clear-screen     # Alt+l
bindkey "^[u" backward-kill-line     # Alt+u
bindkey "^[k" kill-line     # Alt+k

# ============================================================================
# Aliases
# ============================================================================
alias ls="ls --color=auto -lh"
alias lsa='ls --color=auto -lah'
alias vim='nvim'
alias lg='lazygit'
alias a='php artisan'

# ============================================================================
# Tmux
# ============================================================================
alias tmux-ressurect='pgrep -vx tmux > /dev/null && \
		tmux new -d -s delete-me && \
		tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && \
		tmux kill-session -t delete-me && \
		tmux attach || tmux attach'

# ============================================================================
# External Tool Integrations
# ============================================================================
source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# SSH hostname completion
complete -o default -o nospace -W "$(grep "^Host" $HOME/.ssh/config | cut -d" " -f2)" scp sftp ssh rsync

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
