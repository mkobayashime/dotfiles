local package_runner = require("utils/package_runner")

---@type vim.lsp.Config
return {
  -- Resolved per client start rather than at config load, so switching between
  -- projects within one session picks the right binary.
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start(package_runner.wrap(config.root_dir, { 'biome', 'lsp-proxy' }), dispatchers)
  end,
}
