local function format_on_save(client, augroup, bufnr)
  if not client.supports_method('textDocument/formatting') then
    return
  end

  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup,
    buffer = bufnr,
    callback = function()
      -- ESLint is quite slow, especially as a formatter...
      vim.lsp.buf.format({ timeout_ms = 10000 })
    end,
  })
end

return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    null_ls.setup({
      sources = {
        diagnostics.eslint,
        formatting.eslint,
        formatting.stylua.with({
          extra_args = {
            '--call-parentheses',
            'Always',
            '--quote-style',
            'ForceSingle',
            '--indent-type',
            'Spaces',
            '--indent-width',
            '2',
          },
        }),
      },
      on_attach = function(client, bufnr)
        format_on_save(client, augroup, bufnr)
      end,
    })
  end,
}