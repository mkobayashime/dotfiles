augroup colorscheme
  au ColorScheme * call OverrideHighlights()
augroup END

function! OverrideHighlights()
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight CocFloating guibg=NONE ctermbg=NONE
endfunction
