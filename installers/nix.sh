#!/usr/bin/env bash

set -euo pipefail

if [[ -d ~/.nix-profile ]]; then
  echo 'nix already installed'
  exit 0
else
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi
