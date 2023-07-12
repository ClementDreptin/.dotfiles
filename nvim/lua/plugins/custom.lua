return {
  -- colorscheme
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      no_italic = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- lua language server
  {
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
  },

  -- file tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          never_show = { ".git" },
        },
      },
    },
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    opts = {
      -- Disable autocomplete in comments
      enabled = function()
        local in_comment = require("cmp.config.context").in_treesitter_capture("comment") == true
          or require("cmp.config.context").in_syntax_group("Comment")

        return not in_comment
      end,
    },
  },
}
