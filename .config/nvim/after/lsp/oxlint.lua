local package_runner = require("utils/package_runner")

-- lspconfig only looks for `.oxlintrc.json`, so `root_dir` is overridden to also
-- pick up `oxlint.config.ts`.
local root_markers = { '.oxlintrc.json', 'oxlint.config.ts' }

---@type vim.lsp.Config
return {
  -- nvim-lspconfig defaults to the standalone `oxc_language_server` binary,
  -- but the npm package (which mason installs) exposes the LSP via `oxlint --lsp`.
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start(package_runner.wrap(config.root_dir, { 'oxlint', '--lsp' }), dispatchers)
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_dir = function(bufnr, on_dir)
    local dir = vim.fs.root(bufnr, root_markers)
    if dir then
      on_dir(dir)
    end
  end,
}
