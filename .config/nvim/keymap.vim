let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>
nnoremap [dev]    <Nop>
xnoremap [dev]    <Nop>
nmap     m        [dev]
xmap     m        [dev]
nnoremap [ff]     <Nop>
xnoremap [ff]     <Nop>
nmap     z        [ff]
xmap     z        [ff]

" fern
nnoremap <silent> <Leader>e :<C-u>Fern . -drawer -toggle<CR>
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer -toggle -reveal=%<CR>
