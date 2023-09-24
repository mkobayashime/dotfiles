vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "sjis", "euc-jp", "iso-2022-jp" }
vim.opt.fileformats = { "unix", "dos", "mac" }

vim.opt.termguicolors = true

vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.signcolumn = "yes"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = {
  trail = "·",
  tab = ">-",
  nbsp = "␣",
  precedes = "«",
  extends = "»",
}

vim.opt.scrolloff = 5

vim.opt.updatetime = 500

vim.opt.clipboard:append("unnamedplus")
vim.opt.clipboard:append("unnamed")

vim.opt.modeline = true
vim.opt.modelines = 3
