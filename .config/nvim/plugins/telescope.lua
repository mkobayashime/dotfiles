require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = false,
        ["<C-p>"] = false,
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
      n = {
        ["<C-c>"] = "close"
      },
    }
  }
}

require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')
