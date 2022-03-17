#!/usr/bin/env bash

DOTPATH=~/dotfiles

if [[ ! `pwd` -ef "$DOTPATH" ]]; then
  echo "Locate this repository in $DOTPATH"
  exit 1
fi

mkdir -p $HOME/.config

for f in .??* .config/*
do
    [ "$f" = ".git" -o "$f" = ".gitignore" -o "$f" = ".gitmodules" -o "$f" = ".config" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
