#!/usr/bin/env bash

set -euo pipefail

if [[ -d ~/.config/pyenv ]]; then
  echo 'pyenv already installed'
  exit 0
fi

git clone https://github.com/pyenv/pyenv.git ~/.config/pyenv
