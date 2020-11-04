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

### alias

source ~/.aliases

# direnv

eval "$(direnv hook zsh)"
