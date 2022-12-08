#!/usr/bin/env bash

set -euo pipefail

logger_begin() {
  [[ ! "${1:-}" ]] && return 1

  echo ''
  echo '####################'
  echo "INSTALLING $1..."
  echo ''
  echo ''
}

logger_end() {
  [[ ! "${1:-}" ]] && return 1

  echo ''
  echo ''
  if [[ "${2:-0}" == 1 ]]; then
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

  toolname=$(basename "$f" | sed -e 's@\..*@@' || echo '')

  if [[ ! "$toolname" ]]; then
    echo "Failed to get toolname of $f" 1>&2
    continue
  fi

  logger_begin "$toolname"
  if $f; then
    logger_end "$toolname"
  else
    logger_end "$toolname" 1
  fi
done
