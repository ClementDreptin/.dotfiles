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
        -- Format on save
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function(args)
              -- Formatting JS/TS on save just works poorly
              local forbidden_extensions = {
                '.ts',
                '.tsx',
                '.js',
                '.jsx',
              }

              for _, ext in pairs(forbidden_extensions) do
                -- Check if filename ends with extension
                if args.file:sub(-#ext) == ext then
                  return
                end
              end

              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
