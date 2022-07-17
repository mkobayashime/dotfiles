#!/usr/bin/env bash

logger_begin() {
  [[ "$1" == '' ]] && exit 1

  echo ''
  echo '####################'
  echo "INSTALLING $1..."
  echo ''
  echo ''
}

logger_end() {
  [[ "$1" == '' ]] && exit 1

  echo ''
  echo ''
  if [[ "$2" == 1 ]]; then
    echo "COULDN'T INSTALL $1"
  else
    echo "SUCCESSFULLY INSTALLED $1"
  fi
  echo '####################'
  echo ''
}

base_dir=$(dirname "$0")

for f in "$base_dir"/*; do
  [[ "$f" =~ index.sh$ ]] && continue

  toolname=$(basename "$f" | sed -e 's@\..*@@')

  logger_begin "$toolname"
  if $f; then
    logger_end "$toolname"
  else
    logger_end "$toolname" 1
  fi
done
