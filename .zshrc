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
# Pomodoro Timer
# ============================================================================
declare -A pomo_options
pomo_options["work"]="25"
pomo_options["break"]="10"

pomodoro () {
	if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
		val=$1
		echo $val | lolcat
		timer ${pomo_options["$val"]}m
		mpv --no-video --volume=100 /run/current-system/sw/share/sounds/ocean/stereo/alarm-clock-elapsed.oga 2>/dev/null || printf '\a'
	fi
}

alias work="pomodoro 'work'"
alias break="pomodoro 'break'"

# ============================================================================
# External Tool Integrations
# ============================================================================
source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# SSH hostname completion
complete -o default -o nospace -W "$(grep "^Host" $HOME/.ssh/config | cut -d" " -f2)" scp sftp ssh rsync
