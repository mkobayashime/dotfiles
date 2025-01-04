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
    },
  },
})
