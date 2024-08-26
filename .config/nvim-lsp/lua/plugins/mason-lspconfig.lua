require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    -- "cmake",
    "cssls",
    "eslint",
    "html",
    "jsonls",
    "tsserver",
  },
})

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,
})
