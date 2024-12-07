export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/history-search-multi-word

zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Alias
alias vim="nvim"
alias ls="ls --color=auto -lh"
alias a="php artisan"

# Neovim
export PATH="$HOME/.local/share/bob/nvim-bin/:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/home/bruno/.bun/_bun" ] && source "/home/bruno/.bun/_bun" # This loads bun bash_completion

# Laravel
export PATH="/home/bruno/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/bruno/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# GO
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# Fly.io
export FLYCTL_INSTALL="/home/bruno/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
