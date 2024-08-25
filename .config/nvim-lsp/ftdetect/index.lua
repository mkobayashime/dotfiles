vim.filetype.add {
  extension = {
    csv = "csv",
    dat = "csv",
    json = "jsonc",
    mdx = "markdown",
    sh = "bash",
    styl = "stylus",
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
