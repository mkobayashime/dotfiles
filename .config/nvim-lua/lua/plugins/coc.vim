let g:coc_config_home = stdpath('config') .. '/lua/plugins'

let g:coc_global_extensions = [
  \ "coc-css",
  \ "coc-deno",
  \ "coc-diagnostic",
  \ "coc-docker",
  \ "coc-eslint",
  \ "coc-highlight",
  \ "coc-html",
  \ "coc-json",
  \ "coc-omni",
  \ "coc-prettier",
  \ "coc-pyright",
  \ "coc-rust-analyzer",
  \ "coc-sh",
  \ "coc-solargraph",
  \ "coc-spell-checker",
  \ "coc-stylelintplus",
  \ "coc-sumneko-lua",
  \ "coc-tsserver",
  \ "coc-yaml",
\ ]

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" coc-highlight
autocmd CursorMoved,CursorMovedI * call s:cursor_moved()
let s:timer_id = 0
function! s:cursor_moved() abort
  call timer_stop(s:timer_id)
  let s:timer_id = timer_start(500, {-> execute("call CocActionAsync('highlight')")})
endfunction
