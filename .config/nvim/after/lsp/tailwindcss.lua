local util = require("lspconfig.util")

-- lspconfig falls back to `.git` because Tailwind v4 no longer needs
-- `tailwind.config.*`, which starts the server in every repository holding a file
-- of a matching filetype (`markdown` and `css` are in the list). v4 projects still
-- depend on tailwindcss in `package.json`, so that marker covers them instead.
local root_markers = {
  'tailwind.config.js',
  'tailwind.config.cjs',
  'tailwind.config.mjs',
  'tailwind.config.ts',
}

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- `insert_package_json` appends to the table it is given, so it gets a copy.
    local markers = util.insert_package_json(vim.list_slice(root_markers), 'tailwindcss', fname)
    local found = vim.fs.find(markers, { path = fname, upward = true })[1]
    if found then
      on_dir(vim.fs.dirname(found))
    end
  end,
}
