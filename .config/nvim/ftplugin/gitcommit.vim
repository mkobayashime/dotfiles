au FileType gitcommit call s:autoinsert()

function! s:autoinsert() abort
  if $DISABLE_INSERT != 'true'
    startinsert
  endif
endfunction
