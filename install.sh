#!/bin/bash

readonly PATH_TMUX_CONF=$HOME/.tmux.conf

cd $(dirname $0)

# tmux
[ -e $PATH_TMUX_CONF ] && mv $PATH_TMUX_CONF ${PATH_TMUX_CONF}.bak
cp tmux.conf $PATH_TMUX_CONF
