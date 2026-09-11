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

# .bin/typescript/* scripts are committed with a .ts extension so tsc picks them
# up; expose extensionless aliases (on PATH via ~/.bin/typescript) pointing at them
ts_bin="$DOTPATH/.bin/typescript"
find "$ts_bin" -maxdepth 1 -type l ! -name '*.ts' -delete
for f in "$ts_bin"/*.ts; do
  ln -snfv "$(basename "$f")" "${f%.ts}"
done
