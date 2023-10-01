local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"

require("lazy").setup(require("plugins"),
  {
    defaults = {
      lazy = true,
    },
    ui = {
      size = {
        width = 0.8,
        height = 0.9,
      },
      border = "rounded",
      icons = {
        cmd = "",
        config = "",
        event = "",
        ft = "",
        init = "",
        keys = "",
        plugin = "",
        runtime = "",
        source = "",
        start = "",
        task = "",
        lazy = "",
      },
    },
  }
)
