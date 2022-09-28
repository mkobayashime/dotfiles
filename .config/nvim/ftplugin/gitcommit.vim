au FileType gitcommit call s:autoinsert()

function! s:autoinsert() abort
  if $INSERT == 'true'
    startinsert
  endif
endfunction
