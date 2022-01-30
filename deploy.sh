#!/usr/bin/env bash

DOTPATH=~/dotfiles

if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

mkdir -p $HOME/.config

for f in .??* .config/*
do
    [ "$f" = ".git" -o "$f" = ".gitignore" -o "$f" = ".gitmodules" -o "$f" = ".config" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
