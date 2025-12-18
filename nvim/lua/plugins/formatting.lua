-- Setting to control whether format on save is on or off
vim.g.format_on_save = true

-- conform will run a formatter based on the detected file type. conform is a replacement
-- for the formatting part of null-ls/none-ls
local conform = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Don't load until a file is written
  cmd = { "ConformInfo" },
  opts = function()
    -- We use biome if it's available locally, and fallback to prettier otherwise
    local has_biome_exe = vim.fn.executable("node_modules/.bin/biome")
    local web_formatter_to_use = has_biome_exe ~= 0 and "biome-check" or "prettierd"

    return {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { web_formatter_to_use, stop_after_first = true },
        typescript = { web_formatter_to_use, stop_after_first = true },
        javascriptreact = { web_formatter_to_use, stop_after_first = true },
        typescriptreact = { web_formatter_to_use, stop_after_first = true },
        html = { web_formatter_to_use, stop_after_first = true },
        css = { web_formatter_to_use, stop_after_first = true },
        json = { web_formatter_to_use, stop_after_first = true },
        jsonc = { web_formatter_to_use, stop_after_first = true },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
      },
      format_on_save = function(bufnr)
        -- Don't format if setting is disabled
        if not vim.g.format_on_save then
          return
        end

        -- Never run formatter in node_modules
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end

        return {
          lsp_format = "fallback", -- Use the lsp formatter if the file type doesn't match any of the above
        }
      end,
    }
  end,
}

-- Command to toggle format on save
vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
  vim.g.format_on_save = not vim.g.format_on_save
end, {
  desc = "Toggle format on save",
})

-- mason-tool-installer makes sure tools referenced in mason are installed. This plugin is needed
-- because the ensure_installed option from mason-lspconfig only supports LSPs
local mason_tool_installer = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = { "prettierd", "stylua" },
  },
}

return {
  conform,
  mason_tool_installer,
}
