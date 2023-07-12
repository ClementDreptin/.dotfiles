return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { globals = { "vim" } },
        },
      },
    },
  },
}
