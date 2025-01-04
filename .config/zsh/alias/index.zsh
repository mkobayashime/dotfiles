for i in "$HOME/.config/zsh/alias"/*; do
  if [[ ! "$i" =~ /index.zsh$ ]]; then
    source "$i"
  fi
done

alias e='NVIM_APPNAME=nvim-lsp nvim'
alias eo="$EDITOR"

# zsh
alias zmv="noglob zmv"

# global utils
alias -g H="--help"
alias -g V="--version"

# others
if [[ -f "$HOME/.alias_etc" ]]; then
  source ~/.alias_etc
fi

alias '$'=''
