let g:coc_global_extensions = [
  \ "coc-css",
  \ "coc-eslint",
  \ "coc-git",
  \ "coc-html",
  \ "coc-json",
  \ "coc-pairs",
  \ "coc-prettier",
  \ "coc-sh",
  \ "coc-spell-checker",
  \ "coc-tsserver",
\ ]

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
