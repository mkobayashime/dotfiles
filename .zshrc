# profiling
# zmodload zsh/zprof

export XDG_CONFIG_HOME="$HOME/.config"

PRIVATE_DOTFILES_ROOT="$HOME/.dotfiles-private"

# misc

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -d
bindkey -v
bindkey '^?' backward-delete-char

# zsh options

setopt AUTO_LIST
setopt AUTO_MENU
setopt IGNOREEOF
setopt NUMERIC_GLOB_SORT
DIRSTACKSIZE=100
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt BRACECCL

zstyle :compinstall filename '/home/mkobayashime/.zshrc'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _complete _approximate

# prompt

fpath+="$HOME/.config/zsh/pure"
autoload -U promptinit
promptinit
prompt pure

# functions

fpath+="$HOME/.config/zsh/fn"
autoload -Uz "${fpath[-1]}"/*(.:t)
autoload -Uz zmv

# tools

for f in ~/.config/zsh/tools/*; do
  source "$f"
done

# bin

export PATH="$HOME/.bin":"$PATH"
export PATH="$HOME/.bin/typescript":"$PATH"
export PATH="$HOME/.local/bin":"$PATH"

if [[ -d "$PRIVATE_DOTFILES_ROOT/bin" ]]; then
  export PATH="$PRIVATE_DOTFILES_ROOT/bin:$PATH"
fi

# alias

source "$HOME/.config/zsh/alias/index.zsh"

autoload -Uz expandGlobalAlias
zle -N expandGlobalAlias
bindkey '^ ' expandGlobalAlias

# auto completion

autoload -Uz compinit && compinit

fpath+=("$HOME/.config/zsh/completion")

if hascommand brew; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
fi

# private

if [[ -f "$PRIVATE_DOTFILES_ROOT/.zshrc.private" ]]; then
  source "$PRIVATE_DOTFILES_ROOT/.zshrc.private"
fi

# local

if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# plugins

export ADOTDIR="$HOME/.cache/antigen"
source "$HOME/.config/zsh/antigen/bin/antigen.zsh"

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
hascommand nix-env && antigen bundle spwhitt/nix-zsh-completions

antigen apply

# profiling

hascommandlike zprof && zprof
