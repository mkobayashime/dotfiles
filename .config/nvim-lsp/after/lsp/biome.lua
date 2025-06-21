local lspconfig = require('lspconfig')

local isBun = lspconfig.util.root_pattern('bun.lockb', 'bun.lock')(vim.api.nvim_buf_get_name(0))
local isPnpm = lspconfig.util.root_pattern('pnpm-lock.yaml', 'pnpm-lock.json')(vim.api.nvim_buf_get_name(0))

---@type vim.lsp.Config
return {
  cmd = isBun and { 'bunx', 'biome', 'lsp-proxy' } or
      isPnpm and { 'pnpm', 'biome', 'lsp-proxy' } or
      { 'biome', 'lsp-proxy' },
}
