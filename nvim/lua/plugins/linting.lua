-- nvim-lint will run a linter based on the detected file type. nvim-lint is a replacement
-- for the linting part of null-ls/none-ls
local lint = {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" }, -- Don't load until a supported file type is open
  opts = {
    events = { "BufWritePost", "BufReadPost" }, -- Run the linter after opening a buffer or writing a file
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
  config = function(_, opts)
    -- nvim-lint doesn't use the traditional setup function so we have to do the setup manually
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft

    -- Create the auto command that will run every time one of opts.events event occurs
    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}

-- mason-tool-installer makes sure tools referenced in mason are installed. This plugin is needed
-- because the ensure_installed option from mason-lspconfig only supports LSPs
local mason_tool_installer = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = { "eslint_d" },
  },
}

return {
  lint,
  mason_tool_installer,
}
