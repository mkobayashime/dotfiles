return {
  {
    "joshdick/onedark.vim",
    init = function()
      require("plugins/onedark")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- Not lazy: `vim.lsp.enable()` in `lua/lsp.lua` resolves and *caches* every
    -- enabled config as soon as a file is opened from the command line, so the
    -- `lsp/` directory has to be on the runtimepath before then. On `VimEnter`
    -- it was already too late, and the servers with an `after/lsp/` file of
    -- their own kept a resolution missing lspconfig's `cmd` and `filetypes`.
    lazy = false,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "BufEnter",
    dependencies = {
      { "davidmh/cspell.nvim" },
    },
    config = function()
      require("plugins/none-ls")
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VimEnter",
    config = function()
      require("plugins/dressing")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- it explicitly does not support lazy-loading.
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("plugins/nvim-treesitter")
    end,
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require("plugins/nvim-ts-context-commentstring")
        end,
      },
      {
        "romgrk/nvim-treesitter-context",
        opts = {
          max_lines = 10,
        },
      },
      { "andersevenrud/nvim_context_vt" },
      {
        "windwp/nvim-ts-autotag",
        opts = {}
      },
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      require("plugins/rainbow-delimiters")
    end,
    event = 'BufEnter'
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "BufEnter",
    config = function()
      require("plugins/telescope")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
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
    "ray-x/lsp_signature.nvim",
    event = "BufEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "single",
      },
      hint_prefix = "",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "isakbm/gitgraph.nvim",
    event = "CursorHold",
    config = function()
      require("plugins/gitgraph")
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VimEnter",
    opts = {},
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VimEnter",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    event = "VimEnter",
    config = function()
      require("plugins/diffview")
    end,
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
    "gbprod/yanky.nvim",
    event = "VimEnter",
    opts = {
      highlight = {
        timer = 250,
      },
    },
  },
  {
    "mizlan/iswap.nvim",
    event = "CursorHold",
    opts = {
      hl_snipe = "DiffText",
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      map_cr = false,
    },
  },
  {
    "rhysd/clever-f.vim",
    keys = { "f", "F", "t", "T" },
    config = function()
      require("plugins/clever-f")
    end,
  },
  {
    "vim-denops/denops.vim",
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
    main = "ibl",
    event = "VimEnter",
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
      },
      scope = {
        show_start = false,
        show_end = false,
        highlight = "Label",
      },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VimEnter",
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    event = "VimEnter",
    enabled = true,
    config = function()
      require("plugins/neoscroll")
    end,
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
    "kevinhwang91/nvim-bqf",
    event = "CursorHold",
    opts = {
      preview = {
        win_height = 25,
      },
      func_map = {
        pscrollup = "<C-k>",
        pscrolldown = "<C-j>",
      },
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
    "toppair/peek.nvim",
    ft = { "markdown", "pandoc.markdown", "rmd" },
    build = "deno task --quiet build:fast",
    config = function()
      require("plugins/peek")
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
  {
    "digitaltoad/vim-pug",
    ft = "pug",
  },
}
