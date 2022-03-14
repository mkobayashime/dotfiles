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
    },
    vimgrep_arguments = {
      "rg",
      "--hidden",
      "-g",
      "!**/.git/**",
      -- options below are defaults and are required for the functionality
      -- see :help telescope.defaults.vimgrep_arguments
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    }
  }
}

require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')
