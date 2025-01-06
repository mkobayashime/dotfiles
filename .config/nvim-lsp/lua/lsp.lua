function OnLSPAttach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "single",
    focusable = false,
  }
)

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = "single",
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

OnLSPAttach(function(client, buffer)
  if client.supports_method "textDocument/publishDiagnostics"
      or client.name == "null-ls"
  then
    local augroup_diagnostic = vim.api.nvim_create_augroup("lsp_diagnostic", {})
    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      group = augroup_diagnostic,
      buffer = buffer,
      callback = function()
        vim.diagnostic.open_float({ scope = "cursor" })
      end,
    })
  end

  if client.supports_method "textDocument/documentHighlight" then
    local augroup_lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", {})
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

  -- https://eiji.page/blog/neovim-dynamic-capabilities/
  local function format()
    vim.lsp.buf.format({
      timeout_ms = 2000,
      filter = function(client_)
        return client_.name ~= "ts_ls"
      end,
    })
  end

  if client.supports_method("textDocument/formatting") then
    local augroup_formatter = vim.api.nvim_create_augroup("lsp_formatter", {})

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = augroup_formatter,
      buffer = buffer,
      callback = function()
        format()
      end,
    })
    vim.api.nvim_create_user_command("Format", function()
      format()
    end, {})
  end
end)
