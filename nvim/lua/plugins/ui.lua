-- bufferline organizes the open buffers in tabs
local bufferline = {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp", -- Change the buffer name color based on LSP diagnostics
      offsets = {
        -- Offset the tab when the snacks explorer is open
        { filetype = "snacks_layout_box" },
      },
    },
  },
  keys = {
    -- The native bufdelete feature from Neovim causes issues with bufferline so we use a custom plugin
    { "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete current buffer" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<A-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move previous buffer" },
    { "<A-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move previous buffer" },
  },
  config = function(_, opts)
    -- Overwrite the default function that bufferline will call when trying to delete the buffer
    -- (when clicking on the "x" next to the buffer name) to fix alignment issues
    opts.options.close_command = Snacks.bufdelete.delete
    require("bufferline").setup(opts)
  end,
}

-- catppuccin is the colorscheme
local catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    no_italic = true,
    no_bold = true,
    lsp_styles = {
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    integrations = {
      lsp_trouble = true,
      mason = true,
      neotree = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)

    vim.cmd.colorscheme("catppuccin")
  end,
}

-- gitsigns displays git related signs in the sign column (next to the line numbers)
local gitsigns = {
  "lewis6991/gitsigns.nvim",
  opts = {},
}

-- Display inputs in popup windows (based on snacks.nvim)
local inputs = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = { enabled = true },
  },
}

-- lualine recaps information about the current buffer at the bottom of the screen
local lualine = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
}

-- treesitter provides syntax highlighting and indenting
local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = function()
    -- nvim-treesitter relies on the tree-sitter cli so we install it via npm if needed
    if vim.fn.executable("tree-sitter") == 0 then
      local output = vim.fn.system({ "npm", "install", "-g", "tree-sitter-cli" })
      if vim.v.shell_error ~= 0 then
        vim.notify("Failed to install the tree-sitter-cli npm package:\n" .. output, vim.log.levels.ERROR)
        return
      end
    end

    -- Equivalent of running TSUpdate, we need to call the lua function directly because the TSUpdate
    -- isn't yet available when this code runs
    require("nvim-treesitter.install").update()
  end,
  dependencies = {
    -- Helm syntax highlighting
    { "qvalentin/helm-ls.nvim", ft = "helm" },
  },
}

-- treesitter-modules replaces features that used to be built into nvim-treesitter like auto install
-- incremental selection
local treesitter_modules = {
  "MeanderingProgrammer/treesitter-modules.nvim",
  opts = {
    auto_install = true, -- Automatically install a parser when a new file type is encountered
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
}

return {
  bufferline,
  catppuccin,
  gitsigns,
  inputs,
  lualine,
  treesitter,
  treesitter_modules,
}
