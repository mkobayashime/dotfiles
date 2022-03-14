function! stylusSupremacy#format() abort
  if filereadable('./.vscode/settings.json')
    exec 'silent !yarn stylus-supremacy format --replace --options ./.vscode/settings.json <afile>'
    e
  endif
endfunction
