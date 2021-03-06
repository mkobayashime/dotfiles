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

## Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit light zdharma/history-search-multi-word

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

source ~/.alias

# direnv

eval "$(direnv hook zsh)"

# brew

export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"

if [[ `uname` == "Darwin" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

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

# nix

if [ -e /Users/mkobayashime/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/mkobayashime/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
