ALIAS_ROOT="$HOME/.alias"
ALIAS_FILES=(`ls $ALIAS_ROOT | grep -v '^index.zsh$'`)
for i in $ALIAS_FILES
do
  source "$ALIAS_ROOT/$i"
done

if hascommand nvim; then
  alias -g e="nvim"
else
  alias -g e="vim"
fi
alias t="tmux"
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
