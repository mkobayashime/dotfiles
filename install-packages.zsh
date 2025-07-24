main() {
  local nix_packages

  if ! hascommand nix &>/dev/null; then
    echo 'Command not found: nix. Maybe you have to run this from zsh, exiting...'
    exit 1
  fi

  nix_packages=(
    bat
    bun
    delta
    deno
    direnv
    exiftool
    fd
    ffmpeg
    fx
    fzf
    gawk
    gh
    icdiff
    imagemagick
    jq
    nil
    nix-direnv
    nodePackages.cspell
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
    prefixed_nix_packages+=("nixpkgs#$p")
  done

  isMac && {
    for p in "${nix_packages_mac[@]}"; do
      prefixed_nix_packages+=("nixpkgs#$p")
    done
  }

  nix profile add "${prefixed_nix_packages[@]}"
}

main
