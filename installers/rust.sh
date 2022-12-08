#!/usr/bin/env bash

set -euo pipefail

source ~/.config/bash/functions/__hascommand

if __hascommand rustup; then
  echo 'Rust already installed'
  exit 0
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
