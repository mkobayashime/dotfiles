#!/usr/bin/env bash

set -euo pipefail

node_version=20.11.0

if [[ -d ~/.config/nodenv ]]; then
  echo 'nodenv already installed'
  exit 0
fi

git clone https://github.com/nodenv/nodenv.git ~/.config/nodenv
cd ~/.config/nodenv || exit 1
mkdir plugins
cd plugins || exit 1
git clone https://github.com/nodenv/node-build.git
git clone https://github.com/ouchxp/nodenv-nvmrc.git
git clone https://github.com/pine/nodenv-yarn-install.git

export PATH="$HOME/.config/nodenv/bin:$PATH"
export NODENV_ROOT="$HOME/.config/nodenv"
eval "$(nodenv init -)"

nodenv install "$node_version"
nodenv global "$node_version"
