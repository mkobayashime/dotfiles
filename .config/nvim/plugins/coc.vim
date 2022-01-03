let g:coc_global_extensions = [
  \ "coc-css",
  \ "coc-eslint",
  \ "coc-html",
  \ "coc-json",
  \ "coc-pairs",
  \ "coc-prettier",
  \ "coc-sh",
  \ "coc-tsserver",
\ ]

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
