-- File explorer (based on snacks.nvim)
local file_explorer = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { enabled = true },
    picker = {
      sources = {
        explorer = {
          layout = {
            auto_hide = { "input" }, -- Don't display search bar unless we press "/"
          },
        },
      },
    },
  },
  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
  },
}

-- Finder (Telescope replacement, based on snacks.nvim)
local finder = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      hidden = true,
      ignored = true,
      exclude = { ".git" },
    },
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "Find files" },
    { "<leader><space>", function() Snacks.picker.files({ hidden = true }) end, desc = "Find files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>xx", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
  },
}

-- Open Lazygit from within Neovim (based on snacks.nvim)
local lazygit = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    lazygit = { enabled = true },
  },
  keys = {
    { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
  },
}

-- spectre allows finding and replacing text in the whole workspace with a convenient UI
local spectre = {
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    { "<leader>sr", function() require("spectre").open() end, desc = "Find and replace (Spectre)" },
  },
}

-- which-key displays a window with a list of all the configured keymaps with their description
local which_key = {
  "folke/which-key.nvim",
  opts = {},
  init = function()
    -- Display which-key 300ms after typing the first key of a keymap
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
}

return {
  file_explorer,
  finder,
  lazygit,
  spectre,
  which_key,
}
