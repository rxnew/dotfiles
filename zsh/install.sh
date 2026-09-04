#!/bin/bash

readonly ZDOTDIR="$HOME"/.zsh
readonly ZSHENV_PATH="$HOME"/.zshenv
readonly ZSH_PLUGINS_PATH="$ZDOTDIR"/plugins

cd "$(dirname $0)"

echo 'Install .zsh'
mkdir -p "$ZDOTDIR"
for src in $(find .zsh -maxdepth 1 -type f)
do
    dst="$ZDOTDIR/$(basename $src)"
    [[ -e "$dst" ]] && mv "$dst" "$dst".old
    cp "$src" "$dst"
done

echo 'Install .zshenv'
[[ -e "$ZSHENV_PATH" ]] && mv "$ZSHENV_PATH" "${ZSHENV_PATH}".old
cp .zshenv "$ZSHENV_PATH"

if [[ ! -e "$ZSH_PLUGINS_PATH"/zsh-syntax-highlighting ]]
then
    echo 'Install zsh-syntax-highlighting'
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_PATH"/zsh-syntax-highlighting
fi

if [[ ! -e "$ZSH_PLUGINS_PATH"/zsh-autosuggestions ]]
then
    echo 'Install zsh-autosuggestions'
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_PLUGINS_PATH"/zsh-autosuggestions
fi

if [[ ! -e "$HOME"/.fzf ]]
then
    echo 'Install fzf'
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf
    yes | "$HOME"/.fzf/install --no-update-rc --no-bash --no-fish --no-nushell
fi
