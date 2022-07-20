main() {
  local nix_packages nix_prefixed_packages

  if ! hascommand nix-env &> /dev/null; then
    echo 'Maybe you have to run this from zsh, exiting...'
    exit 1
  fi

  nix_packages=(
    deno
    direnv
    fd
    ffmpeg
    fzf
    gh
    gotop
    icdiff
    pdftk
    ripgrep
    saml2aws
    shellcheck
    shfmt
    tmux
    vlc
    whois
    xclip
    yt-dlp
  )

  nix_prefixed_packages=()
  for p in "${nix_packages[@]}"; do
    nix_prefixed_packages+=("nixpkgs.$p")
  done

  nix-env -iA "${nix_prefixed_packages[@]}"
}

main
