return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    local telescope = require('telescope')
    local telescope_builtin = require('telescope.builtin')

    telescope.setup({
      defaults = {
        file_ignore_patterns = { '.git/' }
      }
    })

    -- Enable the native fuzzy finding telescope plugin if it's installed
    pcall(telescope.load_extension, 'fzf')

    -- Keymaps to builtin telescope functions
    vim.keymap.set('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>sf', function() telescope_builtin.find_files({ hidden = true }) end,
    { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
  end
}
