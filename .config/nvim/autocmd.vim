augroup ime
  au!

  if has('unix') && executable('fcitx5-remote')
    autocmd InsertLeave * :call system('fcitx5-remote -c')
  endif

  if has('mac') && executable('swim')
    autocmd InsertLeave * :call system('swim use com.apple.keylayout.ABC')
  endif
augroup END
