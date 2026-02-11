-- Open Lazygit from within Neovim
local lazygit = {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
}

-- neo-tree is a file explorer
local neotree = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        never_show = { ".git" },
      },
      follow_current_file = { enabled = true },
    },
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
}

-- spectre allows finding and replacing text in the whole workspace with a convenient UI
local spectre = {
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Find and replace (Spectre)",
    },
  },
}

-- telescope allows fuzzy finding in a convenient UI
local telescope = {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        file_ignore_patterns = { ".git/" },
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ hidden = true })
        end,
        desc = "Find files",
      },
      {
        "<leader><space>",
        function()
          require("telescope.builtin").find_files({ hidden = true })
        end,
        desc = "Find files",
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep",
      },
    },
  },

  -- telescope-ui-select allows using the telescope UI for other things (like code actions)
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      })

      telescope.load_extension("ui-select")
    end,
  },
}

-- trouble displays a window with all the diagnostics in the workspace
local trouble = {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
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
  lazygit,
  neotree,
  spectre,
  telescope,
  trouble,
  which_key,
}
