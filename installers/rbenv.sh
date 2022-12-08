#!/usr/bin/env bash

set -euo pipefail

ruby_version=3.1.2

if [[ -d ~/.config/rbenv ]]; then
  echo 'rbenv already installed'
  exit 0
fi

git clone https://github.com/rbenv/rbenv.git ~/.config/rbenv
cd ~/.config/rbenv || exit 1
mkdir plugins
cd plugins || exit 1
git clone https://github.com/rbenv/ruby-build.git

export PATH="$HOME/.config/rbenv/bin:$PATH"
export RBENV_ROOT="$HOME/.config/rbenv"
eval "$(rbenv init -)"

rbenv install "$ruby_version"
rbenv global "$ruby_version"

rbenv exec gem install bundler
rbenv rehash
