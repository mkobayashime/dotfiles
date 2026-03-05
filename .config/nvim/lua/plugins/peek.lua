require("peek").setup({
  app = 'browser',
  close_on_bdelete = false,
})

vim.api.nvim_create_user_command("MarkdownPreview", require("peek").open, {})
vim.api.nvim_create_user_command("MarkdownPreviewClose", require("peek").close, {})
