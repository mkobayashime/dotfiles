let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>
nnoremap [_git]   <Nop>
xnoremap [_git]   <Nop>
nmap     gi        [_git]
xmap     gi        [_git]
nnoremap [_quickfix]    <Nop>
xnoremap [_quickfix]    <Nop>
nmap     gl        [_quickfix]
xmap     gl        [_quickfix]

" reload .zshrc
nnoremap <silent> <Leader>rc :call reloadConfig#ReloadConfig()<CR>

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
vnoremap p "_xp
vnoremap P "_xP

" intuitive j/k
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

" move cursor in insert mode
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>

" quickfix list
nnoremap ]q :cn<CR>
nnoremap [q :cp<CR>
nnoremap [_quickfix]f :cfirst<CR>
nnoremap [_quickfix]l :clast<CR>
nnoremap [_quickfix]o :copen<CR>
nnoremap [_quickfix]c :cclose<CR>

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

" === telescope

function! IsInGitDir()
  call system("git rev-parse --is-inside-work-tree")
  return ! v:shell_error
endfunction

nnoremap <Leader>tr :Telescope resume<CR>
nnoremap <expr> <Leader>ff IsInGitDir() ? ":Telescope git_files show_untracked=true<CR>" : ":Telescope find_files<CR>"
nnoremap <expr> <Leader>fF ":Telescope find_files cwd=" . expand('%:p:h') . "<CR>"
nnoremap <Leader>fo :Telescope oldfiles<CR>
nnoremap <Leader>fg :Telescope live_grep<CR>
nnoremap <expr> <Leader>fG ":Telescope live_grep cwd=" . expand('%:p:h') . "<CR>"
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

" === telescope end

" fuzzy-motion.vim
nnoremap <Leader>fm :FuzzyMotion<CR>

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
nnoremap [_git]a :Gitsigns stage_hunk<CR>
vnoremap [_git]a :Gitsigns stage_hunk<CR>
nnoremap [_git]A :Gitsigns stage_buffer<CR>
nnoremap [_git]u :Gitsigns undo_stage_hunk<CR>
nnoremap [_git]r :Gitsigns reset_hunk<CR>
vnoremap [_git]r :Gitsigns reset_hunk<CR>
nnoremap [_git]R :Gitsigns reset_buffer<CR>
nnoremap [_git]s :Gitsigns preview_hunk<CR>
nnoremap [_git]b :lua require"gitsigns".blame_line{full=true}<CR>

" === gitsigns end

" === coc

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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

" popup scroll
nnoremap <nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
nnoremap <nowait><expr> <C-m> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-m>"
inoremap <nowait><expr> <C-n> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<CR>" : "\<C-n>"
inoremap <nowait><expr> <C-m> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<CR>" : "\<C-m>"
vnoremap <nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
vnoremap <nowait><expr> <C-m> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-m>"

" === coc end

" alternate-toggler
nnoremap <Leader>to :ToggleAlternate<CR>

" vim-sandwich
nmap <nowait> ds <Plug>(sandwich-delete)
nmap <nowait> dsb <Plug>(sandwich-delete-auto)
nmap <nowait> ys <Plug>(sandwich-add)
vmap <nowait> ys <Plug>(sandwich-add)
nmap <nowait> cs <Plug>(sandwich-replace)
nmap <nowait> csb <Plug>(sandwich-replace-auto)
omap ib <Plug>(textobj-sandwich-auto-i)
xmap ib <Plug>(textobj-sandwich-auto-i)
omap ab <Plug>(textobj-sandwich-auto-a)
xmap ab <Plug>(textobj-sandwich-auto-a)
omap is <Plug>(textobj-sandwich-query-i)
xmap is <Plug>(textobj-sandwich-query-i)
omap as <Plug>(textobj-sandwich-query-a)
xmap as <Plug>(textobj-sandwich-query-a)