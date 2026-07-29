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
  },
}
