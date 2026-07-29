local M = {}

--- Resolve `cmd` against the project at `root_dir`
--- @param root_dir string?
--- @param cmd string[]
--- @return string[]
function M.wrap(root_dir, cmd)
  if not root_dir then
    return cmd
  end

  -- The version the project pins is the one that should serve it, so
  -- node_modules/.bin wins over whatever `$PATH` happens to hold. Projects
  -- without the binary installed fall through to `$PATH` unchanged.
  local local_bin = root_dir .. '/node_modules/.bin/' .. cmd[1]
  if vim.uv.fs_stat(local_bin) then
    local resolved = vim.list_slice(cmd)
    resolved[1] = local_bin
    return resolved
  end

  return cmd
end

return M
