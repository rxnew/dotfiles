#!/bin/bash

readonly PATH_TMUX_CONF=$HOME/.tmux.conf
readonly PATH_GITIGNORE_GLOBAL=$HOME/.gitignore_global

cd $(dirname $0)

# tmux
[ -e $PATH_TMUX_CONF ] && mv $PATH_TMUX_CONF ${PATH_TMUX_CONF}.bak
cp tmux.conf $PATH_TMUX_CONF
echo 'Install .tmux.conf'

# Git
[ -e $PATH_GITIGNORE_GLOBAL ] && mv $PATH_GITIGNORE_GLOBAL ${PATH_GITIGNORE_GLOBAL}.bak
cp gitignore_global $PATH_GITIGNORE_GLOBAL
git config --global core.excludesfile ~/.gitignore_global \
    || echo 'Please enable to .gitignore_global: git config --global core.excludesfile ~/.gitignore_global'
echo 'Install .gitignore_global'
