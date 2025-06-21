require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "eslint",
    "html",
    "jsonls",
    "lua_ls",
    "ts_ls",
    "yamlls",
  },
})
