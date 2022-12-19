alias ls='ls -v --color=always --group-directories-first'

# BSD
ls --help &> /dev/null
if [[ $? -ne 0 ]]; then
  alias ls='ls -G'
fi

alias ll='ls -alhF'
alias la='ls -A'

alias lsall='ls *'
