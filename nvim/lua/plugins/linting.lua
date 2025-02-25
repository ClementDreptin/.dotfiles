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

    -- Cache for ESLint configuration presence
    local has_eslint_config_cache = nil

    local function has_eslint_config()
      if has_eslint_config_cache ~= nil then
        return has_eslint_config_cache
      end

      -- ESLint supports other config file names but there aren't recommended or even deprecated
      -- so I never use them
      local eslint_config_file_names = {
        "eslint.config.js",
        "eslint.config.mjs",
      }

      -- Check if any of the ESLint config files exist in the workspace
      for _, config in ipairs(eslint_config_file_names) do
        if vim.fn.filereadable(config) == 1 then
          has_eslint_config_cache = true
          return true
        end
      end

      has_eslint_config_cache = false
      return false
    end

    -- Create the auto command that will run every time one of opts.events event occurs
    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        if has_eslint_config() then
          lint.try_lint()
        end
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
