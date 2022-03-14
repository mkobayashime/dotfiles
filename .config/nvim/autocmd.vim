augroup stylusSupremacy
  autocmd!
  au BufWritePost *.styl call stylusSupremacy#format()
augroup END
