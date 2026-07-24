if vim.env.INSERT == "true" then
  vim.cmd("startinsert")
end

vim.keymap.set({ "n", "v" }, "<C-c>", ":wq<CR>")
vim.keymap.set({ "i" }, "<C-c>", "<Esc>:wq<CR>")

--- Equivalent shell command:
---   gh api /users/<user> -q '"Co-Authored-By: \(.name) <\(.id)+\(.login)@users.noreply.github.com>"'
--- Inserts the result at the cursor.
local function insert_coauthor(user)
  user = vim.trim(user or "")

  if user == "" then
    vim.notify("cab: a GitHub username is required", vim.log.levels.ERROR)
    return
  end

  -- jq filter (verbatim incl. surrounding quotes), escaped for Lua
  local jq = '"Co-Authored-By: \\(.name) <\\(.id)+\\(.login)@users.noreply.github.com>"'
  local res = vim.system({ "gh", "api", "/users/" .. user, "-q", jq }):wait()
  if res.code ~= 0 then
    vim.notify("cab: " .. vim.trim(res.stderr or "gh command failed"), vim.log.levels.ERROR)
    return
  end

  local trailer = vim.trim(res.stdout or "")
  if trailer ~= "" then
    vim.api.nvim_put({ trailer }, "c", true, true)
  end
end

-- `:Cab <user-name>` -> insert Co-Authored-By trailer (this buffer only).
vim.api.nvim_buf_create_user_command(0, "Cab", function(opts)
  insert_coauthor(opts.fargs[1])
end, { nargs = 1 })
