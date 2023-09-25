return {
  {
    "joshdick/onedark.vim",
    init = function()
      require("plugins/onedark")
    end,
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    event = "VimEnter",
    init = function()
      require("plugins/coc")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VimEnter",
    build = ":TSUpdate",
    config = function()
      require("plugins/nvim-treesitter")
    end,
    dependencies = {
      {
        url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
        config = function()
          require("plugins/rainbow-delimiters")
        end,
      },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      {
        "romgrk/nvim-treesitter-context",
        opts = {},
      },
      { "andersevenrud/nvim_context_vt" },
      { "windwp/nvim-ts-autotag" },
      -- {
      --   "nvim-treesitter/playground",
      -- },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "BufEnter",
    config = function()
      require("plugins/telescope")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "fannheyward/telescope-coc.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
  },
  {
    "lambdalisue/fern.vim",
    cmd = { "Fern" },
    dependencies = {
      { "lambdalisue/fern-hijack.vim" },
      { "lambdalisue/fern-git-status.vim" },
      { "yuki-yano/fern-preview.vim" },
    },
    config = function()
      vim.g["fern#default_hidden"] = 1
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_priority = 2000,
      },
    },
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VimEnter",
    config = function()
      require("plugins/hlslens")
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VimEnter",
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    event = "VimEnter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("plugins/Comment")
    end,
  },
  {
    "machakann/vim-sandwich",
    event = "CursorHold",
    init = function()
      vim.g.sandwich_no_default_key_mappings = 1
    end,
    config = function()
      require("plugins/vim-sandwich")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      map_cr = false,
    },
  },
  {
    "vim-denops/denops.vim",
    event = "CursorHold",
  },
  {
    "yuki-yano/fuzzy-motion.vim",
    event = "CursorHold",
    dependencis = {
      { "vim-denops/denops.vim" },
    },
  },
  {
    "lambdalisue/kensaku-search.vim",
    event = "CursorHold",
    config = function()
      vim.cmd("cnoremap <CR> <Plug>(kensaku-search-replace)<CR>")
    end,
    dependencies = {
      {
        "lambdalisue/kensaku.vim",
        dependencies = {
          { "vim-denops/denops.vim" },
        },
      },
    },
  },
  {
    "rmagatti/alternate-toggler",
    cmd = "ToggleAlternate",
  },
  {
    "tpope/vim-eunuch",
    event = "CursorHold",
  },
  {
    "bronson/vim-trailing-whitespace",
    event = "CursorHold",
    init = function()
      require("plugins/vim-trailing-whitespace")
    end,
  },
  {
    "kana/vim-textobj-user",
  },
  {
    "kana/vim-textobj-entire",
    event = "CursorHold",
    dependencies = {
      { "kana/vim-textobj-user" },
    },
  },
  {
    "glts/vim-textobj-comment",
    event = "CursorHold",
    dependencies = {
      { "kana/vim-textobj-user" },
    },
  },
  {
    "jceb/vim-textobj-uri",
    event = "CursorHold",
    dependencies = {
      { "kana/vim-textobj-user" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VimEnter",
    opts = {
      show_current_context = true,
      use_treesitter = true,
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VimEnter",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = "CursorHold",
    opts = {
      signs = false,
      highlight = { after = "" },
    },
  },
  {
    "itchyny/vim-qfedit",
    ft = "qf",
  },
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact" },
    opts = {},
  },
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
  },
  {
    "iloginow/vim-stylus",
    ft = { "stylus" },
  },
  {
    "mkobayashime/vim-stylus-supremacy",
    ft = { "stylus" },
  },
  {
    "iamcco/markdown-preview.nvim",
    version = "*",
    ft = { "markdown", "pandoc.markdown", "rmd" },
    build = 'sh -c "cd app && yarn install"',
    config = function()
      require("plugins/markdown-preview")
    end,
  },
  {
    "MTDL9/vim-log-highlighting",
    ft = "log",
  },
  {
    "chrisbra/csv.vim",
    ft = "csv",
  },
}
