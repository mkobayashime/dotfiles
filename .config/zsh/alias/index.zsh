for i in "$HOME/.config/zsh/alias"/*; do
  if [[ ! "$i" =~ /index.zsh$ ]]; then
    source "$i"
  fi
done

alias e="$EDITOR"
alias ya="yarn"

# zsh
alias zmv="noglob zmv"

# global utils
alias -g H="--help"
alias -g V="--version"

# others
if [[ -f "$HOME/.alias_etc" ]]; then
  source ~/.alias_etc
fi
