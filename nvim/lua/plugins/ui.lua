-- bufferline organizes the open buffers in tabs
local bufferline = {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "famiu/bufdelete.nvim",
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp", -- Change the buffer name color based on LSP diagnostics
      offsets = {
        -- Offset the tab when neo-tree is open
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
  keys = {
    {
      "<leader>bd",
      function()
        -- The native bufdelete feature from Neovim causes issues with bufferline so we use a custom plugin
        require("bufdelete").bufdelete()
      end,
      desc = "Delete current buffer",
    },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<A-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move previous buffer" },
    { "<A-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move previous buffer" },
  },
  config = function(_, opts)
    -- Overwrite the default function that bufferline will call when trying to delete the buffer
    -- (when clicking on the "x" next to the buffer name) to fix alignment issues
    opts.options.close_command = require("bufdelete").bufdelete
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

-- dressin displays actions like renaming a variable is a popup menu
local dressing = {
  "stevearc/dressing.nvim",
  opts = {},
}

-- gitsigns displays git related signs in the sign column (next to the line numbers)
local gitsigns = {
  "lewis6991/gitsigns.nvim",
  opts = {},
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
  branch = "master",
  build = ":TSUpdate",
  dependencies = {
    -- Helm syntax highlighting
    { "towolf/vim-helm", ft = "helm" },
  },
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
    ignore_install = { "dockerfile" }, -- The Dockerfile parser is broken
  },
  config = function(_, opts)
    -- When opts is specified, Lazy automatically calls require("<plugin_name>").setup(opts) but with
    -- treesitter the path isn't just the module name so we need to manually call setup
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return {
  bufferline,
  catppuccin,
  dressing,
  gitsigns,
  lualine,
  treesitter,
}
