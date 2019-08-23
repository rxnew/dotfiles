# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt walters

# ${fg[...]} や $reset_color をロード
autoload -U colors; colors

#PROMPT='[%{${fg[white]}%}%n@%m%{${reset_color}%}]$ '
#PROMPT='[%n%{[38;5;179m%}@%m%{[m%}]$ '
PROMPT='[%n%{[38;5;217m%}@%m%{[m%}]$ '

function rprompt-git-current-branch {
    local name st color mark

    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi
    name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
    if [[ -z $name ]]; then
        return
    fi
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color='%{[38;5;2m%}'
        mark=''
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color='%{[38;5;179m%}'
        mark=''
        #elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        #        color=${fg_bold[red]}
    else
        color='%{[38;5;9m%}'
        mark=''
    fi

    # %{..%} は囲まれた文字列がエスケープシーケンスであることを明示する
    # これをしないと右プロンプトの位置がずれる
    echo "(%{$color%}$name%{[m%}$mark) "
}

# プロンプ表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

RPROMPT='`rprompt-git-current-branch`[%{[38;5;7m%}%~%{[m%}]'

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# set Cask path
if [ -d "$HOME/.cask/bin" ]; then
    PATH="$HOME/.cask/bin:$PATH"
fi

# set Go path
if [ -d "$HOME/.go" ]; then
    export GOPATH="$HOME/.go"
fi

# set rbenv path
if [ -d "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
