require("neoscroll").setup({
  mappings = {
    "<C-u>", "<C-d>", "<C-b>", "<C-f>",
    "zt", "zz", "zb",
  },
})

require("neoscroll.config").set_mappings({
  ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150" } },
  ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150" } },
  -- ["<C-y>"] = { "scroll", { "-0.10", "false", "100" } },
  ["<C-k>"] = { "scroll", { "-0.10", "false", "100" } },
  -- ["<C-e>"] = { "scroll", { "0.10", "false", "100" } },
  ["<C-j>"] = { "scroll", { "0.10", "false", "100" } },
  ["zt"]    = { "zt", { "150" } },
  ["zz"]    = { "zz", { "150" } },
  ["zb"]    = { "zb", { "150" } },
})
