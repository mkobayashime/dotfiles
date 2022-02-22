HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
bindkey '^?' backward-delete-char

# zsh options

setopt AUTO_LIST
setopt AUTO_MENU
setopt IGNOREEOF
setopt NUMERIC_GLOB_SORT

zstyle :compinstall filename '/home/mkobayashime/.zshrc'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _complete _approximate

# local

if [ -f "$HOME/.zshrc-local" ]; then
  source "$HOME/.zshrc-local"
fi

# prompt

fpath+="$HOME/.zsh/pure"
autoload -U promptinit; promptinit
prompt pure

# functions

fpath+="$HOME/.zsh/fn"
autoload -Uz $fpath[-1]/*(.:t)
autoload -Uz zmv

# editor

hascommand vi && export EDITOR=vi
hascommand vim && export EDITOR=vim
hascommand nvim && export EDITOR=nvim

# brew

export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"
if [ -e /opt/homebrew/bin/brew ]; then
  ifMac && eval $(/opt/homebrew/bin/brew shellenv)
fi

# nodenv

if hascommand nodenv; then
  export NODENV_ROOT="$HOME/.config/nodenv"
  eval "$(nodenv init -)"
fi

# direnv

if hascommand direnv; then
  eval "$(direnv hook zsh)"
fi

# nix

if [ -e /Users/mkobayashime/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/mkobayashime/.nix-profile/etc/profile.d/nix.sh; fi
if [ -e /home/mkobayashime/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mkobayashime/.nix-profile/etc/profile.d/nix.sh; fi

# fzf

export FZF_DEFAULT_OPTS="--cycle"

# yarn

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# deno

export DENO_INSTALL="$HOME/.deno"

if [ -e "$DENO_INSTALL" ]; then
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

# golang

export GOPATH="$HOME/.go"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"

# alias

source ~/.alias/index.zsh

# bin

export PATH="$HOME/.bin":"$PATH"

# auto completion

fpath=(~/.zsh/completion $fpath)

if hascommand brew; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
fi

autoload -Uz compinit && compinit

# plugins

source $HOME/.zsh/antigen/bin/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git@github.com:spwhitt/nix-zsh-completions.git

antigen apply
