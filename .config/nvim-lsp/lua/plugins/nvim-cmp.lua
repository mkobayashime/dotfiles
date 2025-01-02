local cmp = require("cmp")

local window = cmp.config.window.bordered()
window.border = "single"

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "vsnip" },
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
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end,
    ["<Esc>"] = function(fallback)
      if cmp.visible() then
        cmp.close()
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
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
})
