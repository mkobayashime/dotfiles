vim.api.nvim_create_augroup("colorscheme", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = "colorscheme",
  callback = function()
    -- Transparent background in status line
    vim.api.nvim_set_hl(0, "StatusLine", {})

    -- basic
    vim.api.nvim_set_hl(0, "IncSearch", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "Search", { link = "Visual" })

    -- Transparent background in float
    vim.api.nvim_set_hl(0, "NormalFloat", {})

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

    -- gitgraph
    vim.api.nvim_set_hl(0, "GitGraphHash", { link = "Number" })
    vim.api.nvim_set_hl(0, "GitGraphTimestamp", { link = "Title" })
    vim.api.nvim_set_hl(0, "GitGraphAuthor", { link = "Special" })
    vim.api.nvim_set_hl(0, "GitGraphBranchName", { link = "Title" })
    vim.api.nvim_set_hl(0, "GitGraphBranchTag", { link = "Title" })
    vim.api.nvim_set_hl(0, "GitGraphBranchMsg", { link = "Normal" })
    vim.api.nvim_set_hl(0, "GitGraphBranch1", { link = "Special" })
    vim.api.nvim_set_hl(0, "GitGraphBranch2", { link = "ErrorMsg" })
    vim.api.nvim_set_hl(0, "GitGraphBranch3", { link = "Number" })
    vim.api.nvim_set_hl(0, "GitGraphBranch4", { link = "Title" })
    vim.api.nvim_set_hl(0, "GitGraphBranch5", { link = "Label" })

    -- git-conflict
    vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#22403a" })
    vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "#266156" })
    vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#283e54" })
    vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "#224c70" })
    vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = "#44264d" })
    vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { bg = "#60376b" })
  end,
})
