require("lspsaga").setup({
  ui = {
    border = "single",
    title = false,
  },
  code_action = {
    keys = {
      quit = "<C-k>",
    },
  },
  symbol_in_winbar = {
    enable = false,
  },
  lightbulb = {
    enable = false,
  },
})
