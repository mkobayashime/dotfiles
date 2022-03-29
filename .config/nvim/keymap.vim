let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>
nnoremap [git]    <Nop>
xnoremap [git]    <Nop>
nmap     gi        [git]
xmap     gi        [git]

" reload .zshrc
nnoremap <leader>rc :call reloadConfig#ReloadConfig()<CR>

" disable defaults
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" disable yank
nnoremap x "_x
nnoremap X "_X
nnoremap s "_s
nnoremap S "_S
nnoremap c "_c
nnoremap C "_C
vnoremap p "_xhp
vnoremap P "_xP

" clear highlight
nnoremap <leader>ch <cmd>noh<cr>

" === window

nnoremap <C-w>o <Nop>
nnoremap <C-w><C-o> <Nop>
nnoremap <C-W>m :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

" === window end

" telescope
nnoremap <leader>ff <cmd>Telescope find_files find_command=fd,-H,--type,file,-E,.git<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>f; <cmd>Telescope registers<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gl <cmd>Telescope git_commits<cr>
nnoremap <leader>gfl <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fe <cmd>Telescope coc diagnostics<cr>
nnoremap <leader>fr <cmd>Telescope coc references<cr>
nnoremap <leader>fd <cmd>Telescope coc definitions<cr>
nnoremap <leader>fi <cmd>Telescope coc implementations<cr>

" === fern

nnoremap <silent> <Leader>e :<C-u>Fern . -reveal=%:p<CR>
nnoremap <silent> <Leader>E :<C-u>Fern . -reveal=.<CR>

function! s:init_fern() abort
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <expr> <C-d> g:fern_auto_preview == v:true ? "\<Plug>(fern-action-preview:scroll:down:half)" : "\<C-d>"
  nmap <silent> <buffer> <expr> <C-u> g:fern_auto_preview == v:true ? "\<Plug>(fern-action-preview:scroll:up:half)" : "\<C-u>"
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" === fern end

" === coc

nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>rn <Plug>(coc-rename)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" use <S-tab> to move back to previous complete item
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" popup scroll
nnoremap <nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
nnoremap <nowait><expr> <C-m> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-m>"
inoremap <nowait><expr> <C-n> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<C-n>"
inoremap <nowait><expr> <C-m> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<C-m>"
vnoremap <nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
vnoremap <nowait><expr> <C-m> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-m>"

" Enter when you are in the middle of an paired empty parens
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" === coc end

" alternate-toggler
nnoremap <leader>to :ToggleAlternate<CR>
