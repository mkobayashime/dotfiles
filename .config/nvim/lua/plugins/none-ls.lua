local null_ls = require("null-ls")
local cspell = require("cspell")

local cspell_config = {
  cspell_config_dirs = { "~/.config/" },
}

null_ls.setup({
  sources = {
    cspell.diagnostics.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.INFO
      end,
      config = cspell_config,
    }),
    cspell.code_actions.with({ config = cspell_config }),

    null_ls.builtins.formatting.prettier.with({
      condition = function(utils)
        return utils.root_has_file({
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.yaml",
          ".prettierrc.yml",
          ".prettierrc.js",
          ".prettierrc.cjs",
          "prettier.config.js",
          "prettier.config.cjs",
          ".prettierrc.toml",
        })
      end,
    }),
  },
})
