return {
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectory = { mode = 'auto' },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").on_attach(function(client)
          -- Disable the tsserver formatting to prevent it from conflicting with the eslint formatting
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
