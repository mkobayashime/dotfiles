local neoscroll = require("neoscroll")

local map_options = { remap = false, buffer = true }

vim.keymap.set({ "n" }, "q", ":q<CR>", map_options)

vim.keymap.set({ "n", "v" }, "d", function()
  neoscroll.ctrl_d({ duration = 250 })
end, { remap = false, nowait = true, buffer = true })
vim.keymap.set({ "n", "v" }, "u", function()
  neoscroll.ctrl_u({ duration = 250 })
end, { remap = false, nowait = true, buffer = true })

vim.keymap.set({ "n", "v" }, "j", "2j", map_options)
vim.keymap.set({ "n", "v" }, "k", "2k", map_options)

local augroup_gitgraph = vim.api.nvim_create_augroup("_gitgraph", { clear = true })

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  group = augroup_gitgraph,
  buffer = 0,
  callback = function()
    ---@diagnostic disable-next-line: deprecated
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    if row % 2 == 0 then
      vim.api.nvim_win_set_cursor(0, { row - 1, col })
    end
  end,
})
