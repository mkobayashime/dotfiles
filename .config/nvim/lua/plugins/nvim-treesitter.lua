local ensure_installed = {
  "bash",
  "c",
  "c_sharp",
  "cpp",
  "css",
  "dockerfile",
  "graphql",
  "haskell",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "regex",
  "ruby",
  "rust",
  "scss",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

require("nvim-treesitter").setup()
require("nvim-treesitter").install(ensure_installed)

vim.treesitter.language.register("json", "jsonc")

local max_filesize = 1024 * 1024 -- 1MB

-- Stands in for the `highlight` and `indent` modules the `master` branch used
-- to provide: `main` ships only parsers and queries, so every buffer has to opt
-- into the treesitter features Neovim itself provides.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_attach", { clear = true }),
  callback = function(args)
    -- Parsing a huge file blocks redraws long enough to be painful, so leave
    -- those on the regex syntax engine (this was `highlight.disable` before).
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end

    -- Enables highlighting, and throws for a filetype whose parser is not
    -- installed. That is most of them, so the error cannot be left to bubble up.
    if not pcall(vim.treesitter.start, args.buf) then
      return
    end

    -- Only reached with a parser attached: `indentexpr()` needs one, and the
    -- indent queries are what nvim-treesitter contributes here (Neovim has no
    -- treesitter indentation of its own).
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
