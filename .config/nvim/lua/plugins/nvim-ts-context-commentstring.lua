require("ts_context_commentstring").setup({
  -- The commentstring is recalculated when `gc` asks for it, below, so there is
  -- nothing for the CursorHold autocmd to do.
  enable_autocmd = false,
})

-- Neovim's own `gc` already walks the treesitter tree for a commentstring, but
-- only across injections. JSX comments are ordinary nodes of the same language,
-- so TSX gets `//` where it needs `{/* */}`. `vim.filetype.get_option` is where
-- `vim/_comment.lua` asks, so that is where the answer gets corrected.
local get_option = vim.filetype.get_option

vim.filetype.get_option = function(filetype, option)
  if option ~= "commentstring" then
    return get_option(filetype, option)
  end

  -- Upstream's snippet stops here, but its "is treesitter active" guard is a
  -- pcall around `vim.treesitter.get_parser`, which no longer throws for a
  -- buffer without a parser -- it returns nil and an error string. The guard
  -- passes, the nil is indexed, and the error surfaces here. `gc` never gets
  -- this far without a parser; anything else asking for a commentstring can.
  if not vim.treesitter.get_parser(0, "") then
    return get_option(filetype, option)
  end

  return require("ts_context_commentstring.internal").calculate_commentstring()
      or get_option(filetype, option)
end
