#!/usr/bin/env bash

DOTPATH=~/dotfiles

if [[ ! $(pwd) -ef "$DOTPATH" ]]; then
  echo "Locate this repository in $DOTPATH"
  exit 1
fi

mkdir -p "$HOME/.config"

deploy_targets=(
  .bin
  .vim
  .config/*
  .vimrc
  .zshrc
)

for f in "${deploy_targets[@]}"; do
  ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
