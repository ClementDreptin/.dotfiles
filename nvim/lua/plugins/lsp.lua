local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  tsserver = {},
  jsonls = {},
  rust_analyzer = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

-- All the config needed to make LSPs talk with the LSP client in Neovim
local lsp_config = {
  -- mason is the LSP/formatter/linter/debugger manager
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- mason-lspconfig bridges the gap between mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = vim.tbl_keys(servers),
    },
  },

  -- nvim-lspconfig contains default configurations for a variety of LSPs
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<leader>cd",
        vim.diagnostic.open_float,
        desc = "Line diagnostics",
      },
      {
        "<leader>K",
        vim.lsp.buf.hover,
        desc = "Hover",
      },
      {
        "<leader>gd",
        function()
          require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end,
        desc = "Go to definition",
      },
      {
        "<leader>gr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "References",
      },
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
        desc = "Code actions",
      },
      {
        "<leader>cr",
        vim.lsp.buf.rename,
        desc = "Rename",
      },
    },
    config = function()
      -- Get the completion capabilities of cmp-nvim-lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- For each LSP listed at the top of the file, call the its setup function
      -- with its settings and the completion capabilities of cmp-nvim-lsp
      for server, server_opts in pairs(servers) do
        require("lspconfig")[server].setup({
          capabilities = capabilities,
          settings = server_opts,
        })
      end
    end,
  },
}

-- nvim-cmp is a completion engine, its role is to display completions and expand them
local nvim_cmp = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- nvim-cmp doesn't contain any completions, its only job is display and expand them.
    -- cmp-nvim-lsp is a source of completions that will inject completions from the LSP
    -- attached to the current buffer into nvim-cmp
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      -- Make the popup menus bordered
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Declare cmp-nvim-lsp as a source of completions for nvim-cmp
      }, {
        { name = "buffer" },
      }),
    })
  end,
}

return {
  lsp_config,
  nvim_cmp,
}
