require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "biome",
    "cssls",
    "eslint",
    "html",
    "jsonls",
    "lua_ls",
    "ts_ls",
    "yamlls",
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
    })
  end,
})
