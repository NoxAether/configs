#!/usr/bin/env sh

# Better ls
alias ls='eza --long --binary --git --git-repos --grid'

# FZF History Search
if command -v fzf >/dev/null; then
    function __fzf_history_search {
        local result cmd
        result=$(history | fzf --reverse --height=15 --preview="echo {}" --preview-window=down:3)
        # Using a more robust sed to remove leading numbers and spaces
        [[ -n "$result" ]] && cmd=$(echo "$result" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//')
        [[ -n "$cmd" ]] && {
            READLINE_LINE="$cmd"
            READLINE_POINT=${#cmd}
        }
    }
    bind -x '"\C-r": __fzf_history_search'
fi

# Prompt
export PS1="\[\e[1;35m\]WAKE UP SAMURAI!\[\e[0m\]\n\[\e[38;5;154m\][\u@\h \t] \[\e[36m\]\w > \[\e[0m\]"
