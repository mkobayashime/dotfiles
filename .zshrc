# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mkobayashime/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt auto_list
setopt auto_menu
zstyle ':completion:*:default' menu select=1

fpath+=~/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

### auto completion

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
fpath=(~/.zsh/completion $fpath)

### alias

source ~/.aliases

# direnv

eval "$(direnv hook zsh)"

# brew

export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"

# nodenv

if [ -e "$HOME/.nodenv" ]
then
    export NODENV_ROOT="$HOME/.nodenv"
    export PATH="$NODENV_ROOT/bin:$PATH"
    if command -v nodenv 1>/dev/null 2>&1
    then
        eval "$(nodenv init -)"
    fi
fi

