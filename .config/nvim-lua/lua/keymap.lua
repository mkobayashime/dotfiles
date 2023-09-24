vim.g.mapleader = " "

vim.keymap.set({ "n", "x" }, "<Leader>", "<Nop>")
vim.keymap.set({ "n", "x" }, "[_quickfix]", "<Nop>")
vim.keymap.set({ "n", "x" }, "gl", "[_quickfix]", { remap = true })

-- save
vim.keymap.set("n", "<Leader>w", ":w<CR>")

-- disable defaults
vim.keymap.set("n", "ZZ", "<Nop>")
vim.keymap.set("n", "ZQ", "<Nop>")
vim.keymap.set("n", "Q", "<Nop>")

-- disable yank
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "s", '"_s')
vim.keymap.set("n", "S", '"_S')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("v", "p", '"_xp')
vim.keymap.set("v", "P", '"_xP')

-- intuitive j/k/0/$
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "0", "g0")
vim.keymap.set("n", "$", "g$")

-- move cursor in insert mode
vim.keymap.set("!", "<C-k>", "<Up>")
vim.keymap.set("!", "<C-h>", "<Left>")
vim.keymap.set("!", "<C-l>", "<Right>")
vim.keymap.set("!", "<C-j>", "<Down>")

-- quickfix list
vim.keymap.set("n", "]q", ":cn<CR>")
vim.keymap.set("n", "[q", ":cp<CR>")
vim.keymap.set("n", "[_quickfix]f", ":cfirst<CR>")
vim.keymap.set("n", "[_quickfix]l", ":clast<CR>")
vim.keymap.set("n", "[_quickfix]o", ":copen<CR>")
vim.keymap.set("n", "[_quickfix]c", ":cclose<CR>")

-- clear highlight
vim.keymap.set("n", "<Leader>ch", ":noh<CR>", { silent = true })
