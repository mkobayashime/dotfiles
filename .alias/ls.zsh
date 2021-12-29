alias ls='ls -v --color=auto --group-directories-first'

# BSD
ls --help &> /dev/null
if [[ $? -ne 0 ]]; then
  alias ls='ls -G'
fi

alias ls1='ls -1'

declare -A abbrs=(
  [ll]='ls -alhF'
  [la]='ls -A'
  [l]='ls -CF'
)
for key value in ${(@kv)abbrs}
do
  alias "$key"="$value"
  alias "${key}1"="$value -1"
done
