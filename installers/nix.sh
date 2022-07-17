#!/usr/bin/env bash

if [[ -f ~/.nix-profile/bin/nix ]]; then
  echo 'nix already installed'
  exit 0
else
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi
