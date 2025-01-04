require("gitgraph").setup({
  format = {
    timestamp = "%Y/%m/%d %H:%M:%S",
    fields = { "hash", "timestamp", "author", "branch_name", "tag" },
  },
  hooks = {
    on_select_commit = function(commit)
      vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
    end,
    on_select_range_commit = function(from, to)
      vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
    end,
  },
  symbols = {
    merge_commit = "○",
    commit = "●",
    merge_commit_end = "○",
    commit_end = "●",
  },
})
