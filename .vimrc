call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
call plug#end()
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

syntax enable
colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE

filetype plugin indent on

set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set fileformats=unix,dos,mac

set tabstop=2
set shiftwidth=2
set expandtab

set number

set clipboard+=unnamed
