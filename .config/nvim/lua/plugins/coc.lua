vim.g.coc_config_home = vim.fn.stdpath("config") .. "/lua/plugins"
vim.g.coc_data_home = vim.fn.stdpath("data") .. "/coc"

vim.g.coc_global_extensions = {
  "coc-biome",
  "coc-css",
  "coc-deno",
  "coc-diagnostic",
  "coc-docker",
  "coc-eslint",
  "coc-highlight",
  "coc-html",
  "coc-json",
  "coc-omni",
  "coc-prettier",
  "coc-prisma",
  "coc-pyright",
  "coc-rust-analyzer",
  "coc-sh",
  "coc-solargraph",
  "coc-spell-checker",
  "coc-stylelintplus",
  "coc-sumneko-lua",
  "coc-texlab",
  "coc-tsserver",
  "coc-yaml",
}

vim.api.nvim_create_user_command(
  "Prettier",
  ":CocCommand prettier.formatFile",
  { nargs = 0 }
)

local timer_id = 0
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  callback = function()
    if timer_id ~= 0 then
      vim.fn.timer_stop(timer_id)
    end
    timer_id = vim.fn.timer_start(500, function()
      vim.fn["CocActionAsync"]("highlight")
    end)
  end,
})
