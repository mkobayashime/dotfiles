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
    event = "BufReadPre",
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
        init = function()
          -- The nvim-treesitter module it would otherwise register is gone on
          -- the `main` branch, so skipping it only saves the lookup.
          vim.g.skip_ts_context_commentstring_module = true
        end,
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
    event = 'BufReadPost'
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
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
    "hrsh7th/nvim-cmp",
    -- Not lazy: `lua/lsp.lua` reaches for `cmp_nvim_lsp` to build the LSP
    -- capabilities, and that has to happen before `vim.lsp.enable()` starts a
    -- server. `init.lua` requires `lazy_nvim` before `lsp`, so this lands first.
    lazy = false,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
    },
    config = function()
      require("plugins/nvim-cmp")
    end,
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
    event = "LspAttach",
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
    event = "BufReadPost",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "isakbm/gitgraph.nvim",
    -- No event/cmd/keys: it defines no user commands, and the only entry
    -- point is `require("gitgraph").draw(...)` inside the <Leader>gg mapping
    -- in `keymap.lua`. lazy.nvim hooks `require`, so that call alone loads
    -- this plugin on demand -- an explicit trigger would be redundant.
    config = function()
      require("plugins/gitgraph")
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPost",
    opts = {},
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPost",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    config = function()
      require("plugins/diffview")
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
    event = "BufReadPost",
    opts = {
      highlight = {
        timer = 250,
      },
    },
  },
  {
    "mizlan/iswap.nvim",
    event = "BufReadPost",
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
    "yuki-yano/fuzzy-motion.vim",
    event = "CursorHold",
    dependencies = {
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
    cmd = {
      "Mkdir", "Unlink", "Remove", "Delete", "Copy", "Move", "Duplicate",
      "Rename", "Chmod", "Cfind", "Clocate", "Lfind", "Llocate",
      "SudoEdit", "SudoWrite", "Wall", "W",
    },
  },
  {
    "bronson/vim-trailing-whitespace",
    event = "CursorHold",
    init = function()
      require("plugins/vim-trailing-whitespace")
    end,
  },
  {
    -- Neovim's own `gc` text object only takes a run of whole-line comments,
    -- and only in the line-comment style: a trailing `// ...` and a `/* ... */`
    -- block are both invisible to it. `ic` / `ac` / `aC` still are not.
    "glts/vim-textobj-comment",
    keys = {
      { "ac", mode = { "o", "x" } },
      { "ic", mode = { "o", "x" } },
      { "aC", mode = { "o", "x" } },
    },
    dependencies = {
      { "kana/vim-textobj-user" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
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
    event = "BufReadPost",
    -- The gitsigns and search handlers stay off: the scrollbar carries the
    -- cursor and diagnostics only.
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    event = "VimEnter",
    config = function()
      require("plugins/neoscroll")
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    opts = {
      signs = false,
      highlight = { after = "" },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufReadPost",
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
    "chrisbra/csv.vim",
    ft = "csv",
  },
  {
    "digitaltoad/vim-pug",
    ft = "pug",
  },
}
