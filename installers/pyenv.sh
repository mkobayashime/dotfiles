#!/usr/bin/env bash

if [[ -d ~/.config/pyenv ]]; then
  echo 'pyenv already installed'
  exit 0
fi

git clone https://github.com/pyenv/pyenv.git ~/.config/pyenv
cd ~/.config/pyenv || exit 1
