function OnLSPAttach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    focusable = false,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ">>",
      [vim.diagnostic.severity.WARN] = ">>",
      [vim.diagnostic.severity.INFO] = ">",
      [vim.diagnostic.severity.HINT] = ">",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
})

vim.lsp.enable({
  'bashls',
  'biome',
  'cssls',
  'eslint',
  'html',
  'jsonls',
  'lua_ls',
  'oxfmt',
  'oxlint',
  'ts_ls',
  'yamlls',
})

-- Created once: `nvim_create_augroup` clears the group by default, so creating
-- them inside the LspAttach callback would drop the autocmds of every buffer
-- that attached earlier.
local augroup_diagnostic = vim.api.nvim_create_augroup("lsp_diagnostic", {})
local augroup_lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", {})
local augroup_formatter = vim.api.nvim_create_augroup("lsp_formatter", {})

-- https://eiji.page/blog/neovim-dynamic-capabilities/
local function format()
  vim.lsp.buf.format({
    timeout_ms = 2000,
    filter = function(client_)
      return client_.name ~= "ts_ls"
    end,
  })
end

vim.api.nvim_create_user_command("Format", function()
  format()
end, {})

OnLSPAttach(function(client, buffer)
  if client:supports_method("textDocument/publishDiagnostics")
      or client.name == "null-ls"
  then
    vim.api.nvim_clear_autocmds({ group = augroup_diagnostic, buffer = buffer })
    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      group = augroup_diagnostic,
      buffer = buffer,
      callback = function()
        vim.diagnostic.open_float({ scope = "cursor" })
      end,
    })
  end

  if client:supports_method("textDocument/documentHighlight") then
    vim.api.nvim_clear_autocmds({ group = augroup_lsp_document_highlight, buffer = buffer })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = augroup_lsp_document_highlight,
      buffer = buffer,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = augroup_lsp_document_highlight,
      buffer = buffer,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end

  if client:supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup_formatter, buffer = buffer })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = augroup_formatter,
      buffer = buffer,
      callback = function()
        format()
      end,
    })
  end
end)
