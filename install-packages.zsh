main() {
  local nix_packages

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

  for p in "${nix_packages[@]}"; do
    nix-env -iA "nixpkgs.$p"
  done
}

main
