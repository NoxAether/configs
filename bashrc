#! /usr/bin/bash env

if [ -d "$HOME/.bashrc_conf" ]; then
    # Source main components
    if [ -f "$HOME/.bashrc_conf/environment.bash" ]; then
        . "$HOME/.bashrc_conf/environment.bash"
    fi

     if [ -f "$HOME/.bashrc_conf/functions.bash" ]; then
        . "$HOME/.bashrc_conf/functions.bash"
    fi
fi

export PS1="\[\e[1;35m\]WAKE UP SAMURAI!\[\e[0m\]\n\[\e[38;5;154m\][\u@\h \t] \[\e[36m\]\w > \[\e[0m\]"
