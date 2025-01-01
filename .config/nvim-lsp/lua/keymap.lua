require("utils/bool_fn")

-- basic {{{1

-- leader/prefix {{{2

vim.g.mapleader = " "

vim.keymap.set({ "n", "x" }, "<Leader>", "<Nop>")
vim.keymap.set({ "n", "x" }, "[_git]", "<Nop>")
vim.keymap.set({ "n", "x" }, "gi", "[_git]", { remap = true })
vim.keymap.set({ "n", "x" }, "[_quickfix]", "<Nop>")
vim.keymap.set({ "n", "x" }, "gl", "[_quickfix]", { remap = true })

-- save {{{2

vim.keymap.set("n", "<Leader>w", ":w<CR>", { desc = "Save" })

-- disable defaults {{{2

vim.keymap.set("n", "ZZ", "<Nop>")
vim.keymap.set("n", "ZQ", "<Nop>")
vim.keymap.set("n", "Q", "<Nop>")

-- disable yank {{{2

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "s", '"_s')
vim.keymap.set("n", "S", '"_S')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("v", "p", '"_xp')
vim.keymap.set("v", "P", '"_xP')

-- scroll {{{2

vim.keymap.set({ "n", "v" }, "<C-j>", "<C-e>")
vim.keymap.set({ "n", "v" }, "<C-k>", "<C-y>")

-- intuitive j/k/0/$ {{{2

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "0", "g0")
vim.keymap.set("n", "$", "g$")

-- move cursor in insert mode {{{2

vim.keymap.set("!", "<C-k>", "<Up>")
vim.keymap.set("!", "<C-h>", "<Left>")
vim.keymap.set("!", "<C-l>", "<Right>")
vim.keymap.set("!", "<C-j>", "<Down>")

-- sort {{{2

vim.keymap.set("x", "<Leader>o", ":sort<CR>")

-- quickfix list {{{2

vim.keymap.set("n", "]q", ":cn<CR>", { desc = "Next quickfix location" })
vim.keymap.set("n", "[q", ":cp<CR>", { desc = "Previous quickfix location" })
vim.keymap.set("n", "[_quickfix]f", ":cfirst<CR>", { desc = "First quickfix location" })
vim.keymap.set("n", "[_quickfix]l", ":clast<CR>", { desc = "Last quickfix location" })
vim.keymap.set("n", "[_quickfix]o", ":copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "[_quickfix]c", ":cclose<CR>", { desc = "Close quickfix list" })

-- clear highlight {{{2

vim.keymap.set("n", "<Leader>ch", ":noh<CR>", { silent = true, desc = "Clear highlight" })

-- plugins {{{1

-- telescope {{{2

local function isInGitDir()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

vim.keymap.set("n", "<Leader>tr", ":Telescope resume<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ff",
  function()
    return isInGitDir() and ":Telescope git_files show_untracked=true<CR>" or ":Telescope find_files<CR>"
  end,
  { silent = true, expr = true, desc = ":Telescope git_files / find_files" }
)
vim.keymap.set("n", "<Leader>fF",
  function()
    require("telescope.builtin").find_files({
      cwd = vim.fn.expand("%:p:h"),
    })
  end,
  { silent = true, desc = ":Telescope find_files in the same directory" }
)
vim.keymap.set("n", "<Leader>fo", ":Telescope oldfiles<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fG",
  function()
    require("telescope.builtin").live_grep({
      cwd = vim.fn.expand("%:p:h"),
    })
  end,
  { silent = true, desc = ":Telescope live_grep in the same directory" }
)
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fh", ":Telescope help_tags<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fc", ":Telescope commands<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ft", ":Telescope treesitter<CR>", { silent = true })
vim.keymap.set("n", "<Leader>f;", ":Telescope registers<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fk", ":Telescope keymaps<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gs", ":Telescope git_status<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gb", ":Telescope git_branches<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gl", ":Telescope git_commits<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gfl", ":Telescope git_bcommits<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fe", ":Telescope diagnostics<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fr", ":Telescope lsp_references<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fd", ":Telescope lsp_definitions<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fi", ":Telescope lsp_implementations<CR>", { silent = true })

-- LSP {{{2

function on_lsp_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

-- Toggle hover
on_lsp_attach(function(_, buffer)
  vim.keymap.set("n", "K", function()
    local base_win_id = vim.api.nvim_get_current_win()
    local windows = vim.api.nvim_tabpage_list_wins(0)
    for _, win_id in ipairs(windows) do
      if win_id ~= base_win_id then
        local win_cfg = vim.api.nvim_win_get_config(win_id)
        if win_cfg.relative == "win" and win_cfg.win == base_win_id then
          vim.api.nvim_win_close(win_id, {})
          return
        end
      end
    end
    vim.lsp.buf.hover()
  end, { remap = false, silent = true, buffer = buffer })
end)

on_lsp_attach(function()
  vim.keymap.set({ "n", "v" }, "<Leader>a", ":lua vim.lsp.buf.code_action()<CR>")
  vim.keymap.set("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>")
end)

-- coc {{{2

-- popup menu {{{3

-- vim.cmd [[
-- inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
-- ]]
-- doesn't work with vim-eunuch
-- vim.keymap.set("i", "<CR>",
--   function()
--     return vim.bool_fn["coc#pum#visible"]() and
--         vim.fn["coc#pum#confirm"]() or
--         "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
--   end,
--   { expr = true, silent = true }
-- )

function _G.check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

vim.keymap.set("i", "<TAB>",
  'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
  { silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set("i", "<C-j>",
  'coc#pum#visible() ? coc#pum#next(1) : "<C-j>"',
  { silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set("i", "<S-TAB>",
  [[coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"]],
  { silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set("i", "<C-k>",
  [[coc#pum#visible() ? coc#pum#prev(1) : "<C-k>"]],
  { silent = true, expr = true, replace_keycodes = false }
)

-- fern {{{2

vim.keymap.set({ "n", "x" }, "<Leader>e", ":<C-u>Fern . -reveal=%:p<CR>", { silent = true, desc = "Open Fern" })
vim.keymap.set(
  { "n", "x" },
  "<Leader>E", ":<C-u>Fern . -reveal=.<CR>",
  { silent = true, desc = "Open Fern in project root dir" }
)

vim.api.nvim_create_augroup("fern_custom", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "fern_custom",
  pattern = "fern",
  callback = function()
    vim.keymap.set(
      "n", "<C-p>", "<Plug>(fern-action-preview:auto:toggle)",
      { silent = true, buffer = true, desc = "Toggle file preview" }
    )
    vim.keymap.set("n", "<C-d>",
      function()
        return vim.g.fern_auto_preview and "<Plug>(fern-action-preview:scroll:down:half)" or "<C-d>"
      end,
      { silent = true, buffer = true, expr = true }
    )
    vim.keymap.set("n", "<C-u>",
      function()
        return vim.g.fern_auto_preview and "<Plug>(fern-action-preview:scroll:up:half)" or "<C-u>"
      end,
      { silent = true, buffer = true, expr = true }
    )
  end,
})

-- nvim-treesitter-textsubjects {{{2

vim.keymap.set(
  "v", "<CR>",
  ':lua require("nvim-treesitter.textsubjects").select("textsubjects-smart", true, vim.fn.getpos("\'<"), vim.fn.getpos("\'>"))<CR>'
)

-- gitsigns {{{2

vim.keymap.set("n", "]g",
  function()
    if vim.wo.diff then return "]g" end
    vim.schedule(function() require("gitsigns").next_hunk() end)
    return "<Nop>"
  end,
  { desc = "Next git hunk" }
)
vim.keymap.set("n", "[g",
  function()
    if vim.wo.diff then return "[g" end
    vim.schedule(function() require("gitsigns").prev_hunk() end)
    return "<Nop>"
  end,
  { desc = "Previous git hunk" }
)
vim.keymap.set({ "n", "v" }, "[_git]a", ":Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "[_git]A", ":Gitsigns stage_buffer<CR>")
vim.keymap.set("n", "[_git]u", ":Gitsigns undo_stage_hunk<CR>")
vim.keymap.set({ "n", "v" }, "[_git]r", ":Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "[_git]R", ":Gitsigns reset_buffer<CR>")
vim.keymap.set("n", "[_git]s", ":Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "[_git]b",
  function()
    require("gitsigns").blame_line({ full = true, ignore_whitespace = true })
  end
)

-- vim-sandwich {{{2

vim.keymap.set("n", "ds", "<Plug>(sandwich-delete)", { nowait = true })
vim.keymap.set("n", "dsb", "<Plug>(sandwich-delete-auto)", { nowait = true })
vim.keymap.set({ "n", "v" }, "<Leader>s", "<Plug>(sandwich-add)", { nowait = true })
vim.keymap.set("n", "cs", "<Plug>(sandwich-replace)", { nowait = true })
vim.keymap.set("n", "csb", "<Plug>(sandwich-replace-auto)", { nowait = true })
vim.keymap.set({ "o", "v" }, "ib", "<Plug>(textobj-sandwich-auto-i)")
vim.keymap.set({ "o", "v" }, "ab", "<Plug>(textobj-sandwich-auto-a)")
vim.keymap.set({ "o", "v" }, "is", "<Plug>(textobj-sandwich-query-i)")
vim.keymap.set({ "o", "v" }, "as", "<Plug>(textobj-sandwich-query-a)")

-- yanky.nvim {{{2

vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleForward)")

-- hlslens {{{2

vim.keymap.set("n", "n",
  "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz",
  { silent = true }
)
vim.keymap.set("n", "N",
  "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz",
  { silent = true }
)
vim.keymap.set("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", { silent = true })
vim.keymap.set("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", { silent = true })
vim.keymap.set("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", { silent = true })
vim.keymap.set("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", { silent = true })

-- fuzzy-motion.vim {{{2

vim.keymap.set("n", "<Leader>fm", ":FuzzyMotion<CR>")

-- alternate-toggler {{{2

vim.keymap.set("n", "<Leader>to", ":ToggleAlternate<CR>")

-- {{{1

-- vim: foldmethod=marker
-- vim: foldcolumn=3
-- vim: foldlevel=1
