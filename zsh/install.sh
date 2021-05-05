#!/bin/bash

readonly ZDOTDIR="$HOME"/.zsh
readonly ZSHENV_PATH="$HOME"/.zshenv
readonly ZSH_PLUGINS_PATH="$ZDOTDIR"/plugins

cd "$(dirname $0)"

echo 'Install .zsh'
mkdir -p "$ZDOTDIR"
for src in $(find .zsh -type f)
do
    dst="$ZDOTDIR/$(basename $src)"
    [[ -e "$dst" ]] && mv "$dst" "$dst".bak
    cp "$src" "$dst"
done

echo 'Install .zshenv'
[[ -e "$ZSHENV_PATH" ]] && mv "$ZSHENV_PATH" "${ZSHENV_PATH}".bak
cp .zshenv "$ZSHENV_PATH"

if [[ ! -e "$ZSH_PLUGINS_PATH"/zsh-syntax-highlighting ]]
then
    echo 'Install zsh-syntax-highlighting'
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_PATH"/zsh-syntax-highlighting
fi

if [[ ! -e "$ZSH_PLUGINS_PATH"/zsh-autosuggestions ]]
then
    echo 'Install zsh-autosuggestions'
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_PLUGINS_PATH"/zsh-autosuggestions
fi
