main() {
  local nix_packages

  if ! hascommand nix-env &> /dev/null; then
    echo 'Command not found: nix-env. Maybe you have to run this from zsh, exiting...'
    exit 1
  fi

  nix_packages=(
    bat
    deno
    direnv
    fd
    ffmpeg
    fzf
    gawk
    gh
    gotop
    icdiff
    jq
    pdftk
    ripgrep
    shellcheck
    shfmt
    tmux
    vlc
    whois
    xclip
    yt-dlp
  )

  nix_packages_mac=(
    bash
    gnused
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
