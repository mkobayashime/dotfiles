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
})

OnLSPAttach(function(client, buffer)
  if client.supports_method "textDocument/publishDiagnostics" then
    local augroup_diagnostic = vim.api.nvim_create_augroup("lsp_diagnostic", {})
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = augroup_diagnostic,
      buffer = buffer,
      callback = function()
        vim.diagnostic.open_float({ scope = "cursor" })
      end,
    })
  end

  if client.supports_method "textDocument/documentHighlight" then
    local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", {})
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = lsp_document_highlight,
      buffer = buffer,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = lsp_document_highlight,
      buffer = buffer,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end)
