local actions = require("diffview.actions")

require("diffview").setup({
  view = {
    merge_tool = {
      layout = "diff3_mixed",
    },
  },
  keymaps = {
    view = {
      ["q"] = ":DiffviewClose<CR>",
    },
    file_panel = {
      ["q"] = ":DiffviewClose<CR>",
      ["<C-j>"] = actions.select_next_entry,
      ["<C-k>"] = actions.select_prev_entry,
    },
  },
})
