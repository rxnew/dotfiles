#!/bin/bash

readonly GITIGNORE_GLOBAL_PATH="$HOME"/.gitignore_global

cd "$(dirname $0)"

echo 'Install .gitignore_global'
[ -e "$GITIGNORE_GLOBAL_PATH" ] && mv "$GITIGNORE_GLOBAL_PATH" "$GITIGNORE_GLOBAL_PATH".old
cp .gitignore_global "$GITIGNORE_GLOBAL_PATH"
git config --global core.excludesfile ~/.gitignore_global \
    || echo 'Please enable to .gitignore_global: git config --global core.excludesfile ~/.gitignore_global'
