local package_runner = require("utils/package_runner")

-- nvim-lspconfig ships no `lsp/oxfmt.lua`, so the whole config lives here.
local root_markers = { '.oxfmtrc.json', '.oxfmtrc.jsonc', 'oxfmt.config.ts' }

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start(package_runner.wrap(config.root_dir, { 'oxfmt', '--lsp' }), dispatchers)
  end,
  filetypes = {
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'markdown',
    'typescript',
    'typescriptreact',
    'vue',
    'yaml',
  },
  root_dir = function(bufnr, on_dir)
    local dir = vim.fs.root(bufnr, root_markers)
    if dir then
      on_dir(dir)
    end
  end,
}
