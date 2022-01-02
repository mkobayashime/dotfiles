if &compatible
  set nocompatible
endif

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_path = s:cache_home . '/dein'
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_path)
  echo('Installing dein...')
  echo system('sh <(curl https://raw.githubusercontent.com/shougo/dein.vim/master/bin/installer.sh) ' . shellescape(s:dein_path))
endif
execute 'set runtimepath+=' . s:dein_repo_path

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
