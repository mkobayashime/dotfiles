local cmp = require("cmp")

local window = cmp.config.window.bordered({
  border = "single",
})

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ["<CR>"] = function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm()
      else
        fallback()
      end
    end,
  }),
  window = {
    completion = window,
    documentation = window,
  },
  experimental = {
    ghost_text = false,
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})
