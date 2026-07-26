-- Same markers as lspconfig's `ts_ls`: the server walks a monorepo for the
-- `tsconfig.json` that owns the file, so one server rooted at the package manager
-- lock file covers the whole repository.
local root_markers = {
  { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' },
  { '.git' },
}

--- Command serving TypeScript in the project at `root_dir`, or `nil` when the
--- project has none that can be served.
---
--- `typescript-language-server` drives `node_modules/typescript/lib/tsserver.js`
--- and exits with "Could not find a valid TypeScript installation" without it --
--- it bundles no TypeScript of its own. TypeScript 7 no longer ships that file,
--- serving LSP from the compiler binary instead, so its absence selects the other
--- command. `node_modules/.bin/tsc` is spelled out rather than looked up on
--- `$PATH`: a 5.x / 6.x `tsc` would only reject `--lsp` as an unknown flag.
--- @param root_dir string
--- @return string[]?
local function lsp_cmd(root_dir)
  if vim.uv.fs_stat(root_dir .. '/node_modules/typescript/lib/tsserver.js') then
    return { 'typescript-language-server', '--stdio' }
  end

  local tsc = root_dir .. '/node_modules/.bin/tsc'
  if vim.fn.executable(tsc) == 1 then
    return { tsc, '--lsp', '--stdio' }
  end
end

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start(assert(lsp_cmd(config.root_dir)), dispatchers)
  end,
  root_dir = function(bufnr, on_dir)
    local root_dir = vim.fs.root(bufnr, root_markers)
    if root_dir and lsp_cmd(root_dir) then
      on_dir(root_dir)
    end
  end,
}
