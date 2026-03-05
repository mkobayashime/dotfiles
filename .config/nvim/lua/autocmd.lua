require("utils/bool_fn")

vim.api.nvim_create_augroup("ime", { clear = true })

if vim.bool_fn.has("unix") and vim.bool_fn.executable("fcitx5-remote") then
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = "ime",
    command = "call system('fcitx5-remote -c')",
  })
elseif vim.bool_fn.has("mac") and vim.bool_fn.executable("im-select") then
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = "ime",
    command = "call system('im-select com.apple.keylayout.ABC')",
  })
end
