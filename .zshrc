HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# zsh options

setopt auto_list
setopt auto_menu

zstyle :compinstall filename '/home/mkobayashime/.zshrc'
zstyle ':completion:*:default' menu select=1

# prompt

fpath+="$HOME/.zsh/pure"
autoload -U promptinit; promptinit
prompt pure

# auto completion

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
fpath=(~/.zsh/completion $fpath)

if [[ -d "/opt/homebrew/share/zsh-autosuggestions" ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -d "/home/linuxbrew/.linuxbrew/share/zsh-autosuggestions" ]]; then
  source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -d "/usr/share/zsh-autosuggestions/" ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

autoload -Uz compinit && compinit

# functions

fpath+="$HOME/.zsh/fn"
autoload -Uz $fpath[-1]/*(.:t)

# alias

source ~/.alias

# bin

export PATH="$HOME/.bin":"$PATH"

# brew

export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"

ifMac 'eval $(/opt/homebrew/bin/brew shellenv)'

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

# direnv

eval "$(direnv hook zsh)"

# nix

if [ -e /Users/mkobayashime/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/mkobayashime/.nix-profile/etc/profile.d/nix.sh; fi
if [ -e /home/mkobayashime/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mkobayashime/.nix-profile/etc/profile.d/nix.sh; fi

# fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# yarn

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# deno

export DENO_INSTALL="$HOME/.deno"

if [ -e "$DENO_INSTALL" ]; then
  export PATH="$DENO_INSTALL/bin:$PATH"
fi
