syntax enable
colorscheme molokai

filetype plugin indent on

:set encoding=utf-8
:set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
:set fileformats=unix,dos,mac

set tabstop=4
set shiftwidth=4
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
