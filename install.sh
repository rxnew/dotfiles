#!/bin/bash

readonly PATH_GITIGNORE_GLOBAL=$HOME/.gitignore_global
readonly PATH_TMUX_CONF=$HOME/.tmux.conf
readonly PATH_TMUX_PLUGINS=$HOME/.tmux/plugins

cd $(dirname $0)

# Git
[ -e $PATH_GITIGNORE_GLOBAL ] && mv $PATH_GITIGNORE_GLOBAL ${PATH_GITIGNORE_GLOBAL}.bak
cp gitignore_global $PATH_GITIGNORE_GLOBAL
git config --global core.excludesfile ~/.gitignore_global \
    || echo 'Please enable to .gitignore_global: git config --global core.excludesfile ~/.gitignore_global'
echo 'Install .gitignore_global'

# tmux
[ -e $PATH_TMUX_CONF ] && mv $PATH_TMUX_CONF ${PATH_TMUX_CONF}.bak
cp tmux.conf $PATH_TMUX_CONF
[ -e $PATH_TMUX_PLUGINS/tpm ] && mv $PATH_TMUX_PLUGINS/tpm $PATH_TMUX_PLUGINS/tpm.bak
git clone https://github.com/tmux-plugins/tpm $PATH_TMUX_PLUGINS/tpm
echo 'Install .tmux.conf'
