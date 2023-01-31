let s:nvim_config_dir = expand('~/.config/nvim')

let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

let s:dein_base = $CACHE . '/dein/'
let s:dein_src = s:dein_base . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    if !isdirectory(s:dein_src)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_src
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_src, ':p') , '[/\\]$', '', '')
endif

if dein#load_state(s:dein_base)
  call dein#begin(s:dein_base)
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

execute 'source ' . s:nvim_config_dir . '/basic-options.vim'
execute 'source ' . s:nvim_config_dir . '/keymap.vim'
execute 'source ' . s:nvim_config_dir . '/autocmd.vim'
execute 'source ' . s:nvim_config_dir . '/highlight.vim'
