local M = {}

-- Note: `pnpm exec` / `yarn exec`, not `pnpx` / `yarn dlx`.
-- `pnpx` is an alias of `pnpm dlx`, which runs the package in a *temporary*
-- environment and therefore ignores the version the project pins.
local runners = {
  { lockfiles = { 'bun.lock', 'bun.lockb' }, runner = { 'bunx' } },
  { lockfiles = { 'pnpm-lock.yaml' },        runner = { 'pnpm', 'exec' } },
  { lockfiles = { 'yarn.lock' },             runner = { 'yarn', 'exec' } },
  { lockfiles = { 'package-lock.json' },     runner = { 'npx' } },
}

--- Resolve `cmd` against the project at `root_dir`
--- `use_runner` opts into the runner anyway, for layouts that do not link
--- binaries into node_modules/.bin (e.g. Yarn PnP).
--- @param root_dir string?
--- @param cmd string[]
--- @param use_runner boolean?
--- @return string[]
function M.wrap(root_dir, cmd, use_runner)
  if not root_dir then
    return cmd
  end

  -- node_modules/.bin is preferred: a package manager runner would re-resolve the
  -- binary on every LSP start, and silently download it when it is not installed.
  local local_bin = root_dir .. '/node_modules/.bin/' .. cmd[1]
  if vim.uv.fs_stat(local_bin) then
    local resolved = vim.list_slice(cmd)
    resolved[1] = local_bin
    return resolved
  end

  if use_runner then
    for _, entry in ipairs(runners) do
      if vim.fs.root(root_dir, entry.lockfiles) then
        return vim.list_extend(vim.list_slice(entry.runner), cmd)
      end
    end
  end

  return cmd
end

return M
