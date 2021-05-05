#===================================
# Function
#===================================
fpath=($fpath $ZDOTDIR/completion ~/.zfunc)

# ${fg[...]} や $reset_color をロード
autoload -U colors
colors


#===================================
# Prompt
#===================================
PROMPT=$'%{[38;5;103m%}>%{[m%} '
#PROMPT=$'%{[38;5;103m%}\u276F%{[m%} '


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
        color='%{[38;5;250m%}'
        mark=''
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color='%{[38;5;9m%}'
        mark=''
        #elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        #        color=${fg_bold[red]}
    else
        color='%{[38;5;9m%}'
        mark=''
    fi

    # %{..%} は囲まれた文字列がエスケープシーケンスであることを明示する
    # これをしないと右プロンプトの位置がずれる
    echo "$mark %{$color%}(Git:$name)%{[m%} "
}

# プロンプ表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

RPROMPT='`rprompt-git-current-branch`%{[38;5;103m%}%~%{[m%}'
#RPROMPT='`rprompt-git-current-branch`%{[38;5;4m%}%~%{[m%}'


#===================================
# Key Binds
#===================================
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e


#===================================
# History
#===================================
# 複数のシェルで履歴を共有
#setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=5000
HISTFILE=~/.zsh_history


#===================================
# Completion
#===================================
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


#===================================
# Suggestion
#===================================
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


#===================================
# Syntax Highlight
#===================================
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


#===================================
# Aliases
#===================================
alias ls="ls -FG"
alias ll="ls -lFG"
alias la="ls -alFG"


#===================================
# Environment Specifics
#===================================
for file in $ZDOTDIR/.zshrc_common*
do
    source "$file"
done

for file in $ZDOTDIR/.zshrc_$(uname)*
do
    source "$file"
done

if [[ -f $ZDOTDIR/.zshrc_local ]]
then
    source $ZDOTDIR/.zshrc_local
fi
