-- conform will run a formatter based on the detected file type. conform is a replacement
-- for the formatting part of null-ls/none-ls
local conform = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Don't load until a file is written
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
    },
    format_on_save = {
      lsp_fallback = true, -- Use the lsp formatter if the file type doesn't match any of the above
      async = false,
    },
  },
}

-- mason-tool-installer makes sure tools referenced in mason are installed. This plugin is needed
-- because the ensure_installed option from mason-lspconfig only supports LSPs
local mason_tool_installer = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  config = function(_, opts)
    vim.list_extend(opts.ensure_installed, { "prettierd", "stylua" })
    require("mason-tool-installer").setup(opts)
  end,
}

return {
  conform,
  mason_tool_installer,
}
