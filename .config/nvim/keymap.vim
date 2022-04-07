let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>
nnoremap [git]    <Nop>
xnoremap [git]    <Nop>
nmap     gi        [git]
xmap     gi        [git]

" reload .zshrc
nnoremap <Leader>rc :call reloadConfig#ReloadConfig()<CR>

" save
nnoremap <Leader>w :w<CR>

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

" move cursor in insert mode
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>

" clear highlight
nnoremap <Leader>ch :noh<CR>

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
nnoremap <Leader>ff :Telescope find_files find_command=fd,-H,--type,file,-E,.git<CR>
nnoremap <expr> <Leader>fu ":Telescope find_files find_command=fd,-H,--type,file,-E,.git cwd=" . expand('%:p:h') . "<CR>"
nnoremap <Leader>fo :Telescope oldfiles<CR>
nnoremap <Leader>fgg :Telescope live_grep<CR>
nnoremap <expr> <Leader>fgh ":Telescope live_grep cwd=" . expand('%:p:h') . "<CR>"
nnoremap <Leader>fb :Telescope buffers<CR>
nnoremap <Leader>fh :Telescope help_tags<CR>
nnoremap <Leader>fc :Telescope commands<CR>
nnoremap <Leader>ft :Telescope treesitter<CR>
nnoremap <Leader>f; :Telescope registers<CR>
nnoremap <Leader>gs :Telescope git_status<CR>
nnoremap <Leader>gb :Telescope git_branches<CR>
nnoremap <Leader>gl :Telescope git_commits<CR>
nnoremap <Leader>gfl :Telescope git_bcommits<CR>
nnoremap <Leader>fe :Telescope coc diagnostics<CR>
nnoremap <Leader>fr :Telescope coc references<CR>
nnoremap <Leader>fd :Telescope coc definitions<CR>
nnoremap <Leader>fi :Telescope coc implementations<CR>

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

" === gitsigns

nnoremap <expr> ]g &diff ? ']g' : ':Gitsigns next_hunk<CR>'
nnoremap <expr> [g &diff ? '[g' : ':Gitsigns prev_hunk<CR>'
nnoremap [git]a :Gitsigns stage_hunk<CR>
vnoremap [git]a :Gitsigns stage_hunk<CR>
nnoremap [git]A :Gitsigns stage_buffer<CR>
nnoremap [git]u :Gitsigns undo_stage_hunk<CR>
nnoremap [git]r :Gitsigns reset_hunk<CR>
vnoremap [git]r :Gitsigns reset_hunk<CR>
nnoremap [git]R :Gitsigns reset_buffer<CR>
nnoremap [git]s :Gitsigns preview_hunk<CR>
nnoremap [git]b :lua require"gitsigns".blame_line{full=true}<CR>

" === gitsigns end

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

vmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>rn <Plug>(coc-rename)

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
inoremap <nowait><expr> <C-n> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<CR>" : "\<C-n>"
inoremap <nowait><expr> <C-m> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<CR>" : "\<C-m>"
vnoremap <nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
vnoremap <nowait><expr> <C-m> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-m>"

" Enter when you are in the middle of an paired empty parens
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" === coc end

" alternate-toggler
nnoremap <Leader>to :ToggleAlternate<CR>
