DOTPATH=~/dotfiles

if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

for f in .??* .config/*
do
    [ "$f" = ".git" -o "$f" = ".gitignore" -o "$f" = ".gitmodules" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
