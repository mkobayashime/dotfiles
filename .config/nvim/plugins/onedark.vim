if (has("autocmd"))
  augroup colorextend
    autocmd!
    autocmd ColorScheme * call onedark#extend_highlight("Normal", { "bg": { "gui": "None", "cterm": "None" } })
  augroup END
endif
