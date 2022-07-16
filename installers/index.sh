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
  echo "SUCCESSFULLY INSTALLED $1"
  echo '####################'
  echo ''
}

base_dir=$(dirname "$0")

for f in "$base_dir"/*; do
  [[ "$f" =~ index.sh$ ]] && continue

  toolname=$(basename "$f" | sed -e 's@\..*@@')

  logger_begin "$toolname"
  $f
  logger_end "$toolname"
done
