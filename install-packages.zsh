main() {
  local nix_packages

  if ! hascommand nix-env &> /dev/null; then
    echo 'Command not found: nix-env. Maybe you have to run this from zsh, exiting...'
    exit 1
  fi

  nix_packages=(
    bat
    delta
    deno
    direnv
    exiftool
    fd
    ffmpeg
    fzf
    gawk
    gh
    icdiff
    imagemagick
    jq
    pdftk
    ripgrep
    shellcheck
    shfmt
    tmux
    whois
    xclip
    yt-dlp
  )

  nix_packages_mac=(
    bash
    coreutils
    findutils
    gnugrep
    gnused
    wget
  )

  prefixed_nix_packages=()

  for p in "${nix_packages[@]}"; do
    prefixed_nix_packages+=("nixpkgs.$p")
  done

  isMac && {
    for p in "${nix_packages_mac[@]}"; do
      prefixed_nix_packages+=("nixpkgs.$p")
    done
  }

  nix-env -iA "${prefixed_nix_packages[@]}"
}

main
