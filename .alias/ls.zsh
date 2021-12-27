alias ls="ls -v --color=auto --group-directories-first"
alias -g ll="ls -alhF"
alias -g la="ls -A"
alias -g l="ls -CF"

# BSD
ls --help &> /dev/null
if [[ $? -ne 0 ]]; then
  alias ls="ls -G"
fi
