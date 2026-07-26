-- Neovim has no built-in path completion source: 'complete' scans buffer
-- *contents*, and its "f" flag completes buffer *names*, never paths on disk.
-- This fills the gap left by cmp-path, as a |complete-functions| source that
-- 'complete' picks up through its "F{func}" flag.

-- Whitespace and the delimiters that surround paths in source code and markup.
-- A path token is everything up to the cursor that is none of these.
local TOKEN = "[^%s\"'`(),;:=<>|%[%]{}]*$"

-- Marks the items produced here, so that only they drive the continuation below.
local MARKER = "complete_path"

-- |complete-functions| is called twice, first for the start column and then for
-- the matches. Only the first call can see the text before the cursor, so the
-- directory it resolves has to be kept for the second.
local dir = nil

--- Start column of the path segment under the cursor, nil outside a path
--- @return integer?
local function path_start()
  local col = vim.fn.col(".") - 1
  local token = vim.api.nvim_get_current_line():sub(1, col):match(TOKEN) or ""

  -- A "/" is what marks the token as a path, mirroring cmp-path's trigger
  -- characters. Without one, every word typed in insert mode would reach for
  -- the filesystem.
  dir = token:match("^(.*/)")
  if not dir then
    return nil
  end

  -- Start at the last segment, so the matches below are plain basenames.
  return col - #token + #dir
end

--- Entries of the directory resolved by `path_start`, as |complete-items|
--- @param base string
--- @return table[]
local function path_items(base)
  if not dir then
    return {}
  end

  -- Relative paths resolve against the buffer's own directory, not the working
  -- directory, which is how cmp-path behaved.
  local prefix = dir
  if not prefix:match("^[/~]") then
    prefix = vim.fn.expand("%:p:h") .. "/" .. prefix
  end

  local items = {}
  for _, path in ipairs(vim.fn.getcompletion(prefix .. base, "file")) do
    -- Directories keep their trailing slash so the next segment can follow.
    items[#items + 1] = { word = path:match("([^/]*/?)$"), user_data = MARKER }
  end
  return items
end

--- Exposed as a global because 'complete' takes a function *name* and `v:lua`
--- reaches globals only. `OnLSPAttach` in `lua/lsp.lua` sets the precedent.
--- @param findstart 0|1
--- @param base string
--- @return integer|table
function _G.CompletePath(findstart, base)
  if findstart == 1 then
    -- Outside a path the source contributes nothing, and starting at the cursor
    -- leaves the other sources in 'complete' to work from their own column.
    return path_start() or (vim.fn.col(".") - 1)
  end

  -- Typing a "/" descends into a directory, which moves the start column and
  -- invalidates the cached list, so the matches cannot be filtered in place.
  return { words = path_items(base), refresh = "always" }
end

-- Accepting an item ends completion, and 'autocomplete' only re-triggers on a
-- typed character, so choosing a directory would otherwise stop there instead of
-- offering what it contains. nvim-cmp got this for free: "/" is one of
-- cmp-path's trigger characters, so confirming a directory re-triggered it.
local CONTINUE = "<Plug>(complete-path-continue)"

--- |complete()| is documented to work from a <Cmd> mapping, which is why the
--- autocommand below reaches it through one instead of calling it directly.
--- Only the entries of the new directory are offered: re-triggering with CTRL-N
--- would run every source in 'complete', and the leader after a "/" is empty, so
--- the buffer source would answer with every word it knows.
function _G.CompletePathContinue()
  local start = path_start()
  if not start then
    return
  end

  local items = path_items("")
  if #items == 0 then
    return
  end

  -- The cursor sits just after the "/", so nothing is replaced. |complete()|
  -- counts the column from 1.
  vim.fn.complete(start + 1, items)
end

vim.keymap.set("i", CONTINUE, "<Cmd>lua CompletePathContinue()<CR>", { silent = true })

vim.api.nvim_create_autocmd("CompleteDone", {
  group = vim.api.nvim_create_augroup("complete_path", {}),
  callback = function()
    if vim.v.completed_item.user_data ~= MARKER then
      return
    end

    -- `complete_word` is empty when the menu was dismissed rather than accepted.
    if not vim.endswith(vim.v.event.complete_word or "", "/") then
      return
    end

    -- Feeding the mapping defers this until Nvim has left completion mode. "m"
    -- remaps, which is what resolves the <Plug> left-hand side.
    vim.api.nvim_feedkeys(vim.keycode(CONTINUE), "m", false)
  end,
})
