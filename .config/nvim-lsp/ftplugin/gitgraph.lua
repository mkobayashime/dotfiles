local neoscroll = require("neoscroll")

vim.keymap.set({ "n", "v" }, "d", function()
  neoscroll.ctrl_d({ duration = 250 })
end, { remap = false, nowait = true, buffer = true })
vim.keymap.set({ "n", "v" }, "u", function()
  neoscroll.ctrl_u({ duration = 250 })
end, { remap = false, nowait = true, buffer = true })

vim.keymap.set({ "n" }, "q", ":q<CR>", { remap = false, buffer = true })
