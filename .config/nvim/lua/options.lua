vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "sjis", "euc-jp", "iso-2022-jp" }
vim.opt.fileformats = { "unix", "dos", "mac" }

vim.opt.termguicolors = true

vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.signcolumn = "yes"

vim.opt.autocomplete = true

-- The LSP comes first because sources earlier in 'complete' are given more of
-- the decaying time slice. Buffer words are scanned in the current buffer only,
-- which is the extent cmp-buffer covered.
vim.opt.complete = { "o", "." }

-- `noselect` leaves the buffer untouched until an item is chosen, `popup` shows
-- the documentation of the selected item and is also what makes
-- `vim.lsp.completion` request `completionItem/resolve`, and `fuzzy` replaces
-- nvim-cmp's matcher. `preinsert` is deliberately absent: nvim-cmp ran with
-- `ghost_text = false`.
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup", "fuzzy" }

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.winborder = "single"

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
