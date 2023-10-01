function! reloadConfig#ReloadConfig()
  if confirm('Reload config?', "&yes\n&no", 1) == 1
    source $MYVIMRC
    echo "Reloaded"
  endif
endfunction
