if vim.env.INSERT == "true" then
  vim.cmd("startinsert")
end

vim.keymap.set({ "n", "v" }, "<C-c>", ":wq<CR>")
vim.keymap.set({ "i" }, "<C-c>", "<Esc>:wq<CR>")
