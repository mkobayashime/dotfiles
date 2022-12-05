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

  for p in "${nix_packages[@]}"; do
    nix-env -iA "nixpkgs.$p"
  done

  isMac && {
    for p in "${nix_packages_mac[@]}"; do
      nix-env -iA "nixpkgs.$p"
    done
  }
}

main
