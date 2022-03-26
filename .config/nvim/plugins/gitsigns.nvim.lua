require('gitsigns').setup {
  current_line_blame = true,
  word_diff = true,

  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']g', "&diff ? ']g' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[g', "&diff ? '[g' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map('n', '[git]a', ':Gitsigns stage_hunk<CR>')
    map('v', '[git]a', ':Gitsigns stage_hunk<CR>')
    map('n', '[git]A', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '[git]u', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '[git]r', ':Gitsigns reset_hunk<CR>')
    map('v', '[git]r', ':Gitsigns reset_hunk<CR>')
    map('n', '[git]R', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '[git]s', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '[git]b', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
  end
}
