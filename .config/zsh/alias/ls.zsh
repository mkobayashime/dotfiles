alias ls='ls -v --color=always --group-directories-first'

# BSD

if ! ls --help &> /dev/null; then
  alias ls='ls -G'
fi

alias ll='ls -alhF'
alias la='ls -A'

alias lsall='ls *'
