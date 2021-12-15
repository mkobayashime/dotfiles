HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# zsh options

setopt auto_list
setopt auto_menu
setopt IGNOREEOF

zstyle :compinstall filename '/home/mkobayashime/.zshrc'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _complete _approximate

# prompt

fpath+="$HOME/.zsh/pure"
autoload -U promptinit; promptinit
prompt pure

# functions

fpath+="$HOME/.zsh/fn"
autoload -Uz $fpath[-1]/*(.:t)
autoload -Uz zmv

# alias

source ~/.alias

# bin

export PATH="$HOME/.bin":"$PATH"

# brew

export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"
ifMac && eval $(/opt/homebrew/bin/brew shellenv)

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

if type direnv &>/dev/null
then
  eval "$(direnv hook zsh)"
fi

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

# auto completion

fpath=(~/.zsh/completion $fpath)

zshAutosuggestionsPathPrefix=(
  "/opt/homebrew/share"
  "/home/linuxbrew/.linuxbrew/share"
  "/usr/share"
)
for i in "${zshAutosuggestionsPathPrefix[@]}"
do
  if [[ -d "$i/zsh-autosuggestions" ]]; then
    source "$i/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi
done

if type brew &>/dev/null
then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
fi

autoload -Uz compinit && compinit

# plugins

source $HOME/.zsh/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git@github.com:spwhitt/nix-zsh-completions.git

antigen apply
