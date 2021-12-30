alias -g ls='ls -v --color=always --group-directories-first'

# BSD
ls --help &> /dev/null
if [[ $? -ne 0 ]]; then
  alias -g ls='ls -G'
fi

alias -g ls1='ls -1'

declare -A abbrs=(
  [ll]='ls -alhF'
  [la]='ls -A'
)
for key value in ${(@kv)abbrs}
do
  alias -g "$key"="$value"
  alias -g "${key}1"="$value -1"
done
