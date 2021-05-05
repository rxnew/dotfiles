#!/bin/bash

readonly TMUX_CONF_PATH="$HOME"/.tmux.conf
readonly TMUX_PLUGINS_PATH="$HOME"/.tmux/plugins

cd "$(dirname $0)"

echo 'Install .tmux.conf'
[[ -e "$TMUX_CONF_PATH" ]] && mv "$TMUX_CONF_PATH" "$TMUX_CONF_PATH".bak
cp .tmux.conf "$TMUX_CONF_PATH"

if [[ ! -e "$TMUX_PLUGINS_PATH"/tpm ]]
then
    echo 'Install Tmux Plugin Manager'
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGINS_PATH"/tpm
fi
