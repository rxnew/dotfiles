#!/bin/bash

readonly PATH_GITIGNORE_GLOBAL=$HOME/.gitignore_global
readonly PATH_ZSHRC=$HOME/.zshrc
readonly PATH_ZSH_PLUGINS=$HOME/.zsh/plugins
readonly PATH_TMUX_CONF=$HOME/.tmux.conf
readonly PATH_TMUX_PLUGINS=$HOME/.tmux/plugins

cd $(dirname $0)

# Git
[ -e $PATH_GITIGNORE_GLOBAL ] && mv $PATH_GITIGNORE_GLOBAL ${PATH_GITIGNORE_GLOBAL}.bak
cp gitignore_global $PATH_GITIGNORE_GLOBAL
git config --global core.excludesfile ~/.gitignore_global \
    || echo 'Please enable to .gitignore_global: git config --global core.excludesfile ~/.gitignore_global'
echo 'Install .gitignore_global'

# zsh
[ -e $PATH_ZSHRC ] && mv $PATH_ZSHRC ${PATH_ZSHRC}.bak
cp zshrc $PATH_ZSHRC
[ -e $PATH_ZSH_PLUGINS/zsh-syntax-highlighting ] \
    || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PATH_ZSH_PLUGINS/zsh-syntax-highlighting
[ -e $PATH_ZSH_PLUGINS/zsh-autosuggestions ] \
    || git clone https://github.com/zsh-users/zsh-autosuggestions.git $PATH_ZSH_PLUGINS/zsh-autosuggestions
echo 'Install .zshrc'

# tmux
[ -e $PATH_TMUX_CONF ] && mv $PATH_TMUX_CONF ${PATH_TMUX_CONF}.bak
cp tmux.conf $PATH_TMUX_CONF
[ -e $PATH_TMUX_PLUGINS/tpm ] \
    || git clone https://github.com/tmux-plugins/tpm $PATH_TMUX_PLUGINS/tpm
echo 'Install .tmux.conf'
