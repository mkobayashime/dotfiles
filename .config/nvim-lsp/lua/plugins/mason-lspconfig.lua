require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "eslint",
    "html",
    "jsonls",
    "ts_ls",
  },
})

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({})
  end,
})
