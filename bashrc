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


