local group = vim.api.nvim_create_augroup("DetectTypeScriptShebang", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = group,
  pattern = "*",
  callback = function()
    local line = vim.fn.getline(1)
    if line == "#!/usr/bin/env node" or line == "#!/usr/bin/env bun" then
      vim.bo.filetype = "typescript"
    end
  end,
})
