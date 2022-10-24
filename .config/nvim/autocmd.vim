augroup ime
  au!

  if has('unix') && executable('fcitx5-remote')
    autocmd InsertLeave * :call system('fcitx5-remote -c')
  endif

  if has('mac') && executable('im-select')
    autocmd InsertLeave * :call system('im-select com.apple.keylayout.ABC')
  endif
augroup END
