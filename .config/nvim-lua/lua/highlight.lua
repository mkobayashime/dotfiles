vim.api.nvim_create_augroup("colorscheme", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = "colorscheme",
  callback = function()
    -- extend onedark
    vim.fn["onedark#extend_highlight"]("StatusLine", {
      bg = {
        gui = "None",
        cterm = "None",
        cterm16 = "None",
      },
    })

    -- basic
    vim.api.nvim_set_hl(0, "IncSearch", { link = "DiffAdd" })

    -- coc
    vim.api.nvim_set_hl(0, "NormalFloat", {})
    vim.api.nvim_set_hl(0, "CocFloating", { link = "NormalFloat" })

    -- treesitter-context
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })

    -- fuzzy-motion
    vim.api.nvim_set_hl(0, "FuzzyMotionShade", { fg = "#5C6370" })
    vim.api.nvim_set_hl(0, "FuzzyMotionChar", { fg = "#282C34", bg = "#ff7a90", bold = true, underline = true })
    vim.api.nvim_set_hl(0, "FuzzyMotionSubChar", { fg = "#282C34", bg = "#FFAF60", bold = true, underline = true })
    vim.api.nvim_set_hl(0, "FuzzyMotionMatch", { fg = "#7ee787" })

    -- vim-trailing-whitespace
    vim.api.nvim_set_hl(0, "ExtraWhitespace",
      { bg = "#E06C75", fg = "#282C34", ctermbg = 204, ctermfg = 235 }
    )

    -- hlslens
    vim.api.nvim_set_hl(0, "HlSearchLensNear", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "HlSearchLens", { link = "Visual" })

    -- git-conflict
    vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#22403a" })
    vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "#266156" })
    vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#283e54" })
    vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "#224c70" })
    vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = "#44264d" })
    vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { bg = "#60376b" })
  end,
})
