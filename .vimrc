call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
call plug#end()

syntax enable
colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE

filetype plugin indent on

:set encoding=utf-8
:set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
:set fileformats=unix,dos,mac

set tabstop=2
set shiftwidth=2
set expandtab

if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif
