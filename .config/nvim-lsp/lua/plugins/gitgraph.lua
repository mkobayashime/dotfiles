require("gitgraph").setup({
  format = {
    timestamp = "%Y/%m/%d %H:%M:%S",
    fields = { "hash", "timestamp", "author", "branch_name", "tag" },
  },
})
