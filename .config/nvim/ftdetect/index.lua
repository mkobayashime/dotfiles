vim.filetype.add {
  extension = {
    dat = "csv",
    json = "jsonc",
    mdx = "markdown",
    sh = "bash",
    zsh = "bash",
    log = "log",
  },
  filename = {
    [".envrc"] = "bash",
    [".zshrc"] = "bash",
  },
  pattern = {
    [".*ignore"] = "gitignore",
    ["%.zshrc.*"] = "bash",
    [".*/%.config/zsh/fn/.*"] = "bash",
    [".*/%.config/zsh/completion/.*"] = "bash",
    [".*/%.config/zsh/tools/.*"] = "bash",
    [".*/%.config/bash/functions/.*"] = "bash",
    -- Extensionless `node` / `bun` scripts are TypeScript here. Neovim reads
    -- that shebang as javascript, and its content matching runs after every
    -- pattern, so this has to be a pattern rather than a contents rule -- but
    -- at the lowest priority, which puts it behind the extension table, so a
    -- file that already names its language keeps it.
    [".*"] = {
      function(_, bufnr)
        if not bufnr then
          return
        end

        local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
        if first_line == "#!/usr/bin/env node" or first_line == "#!/usr/bin/env bun" then
          return "typescript"
        end
      end,
      { priority = -math.huge },
    },
  },
}
