vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup({
      view = {
        adaptive_size = true,
      },
    })

    -- Open nvim-tree on startup only if it's a directory
    vim.api.nvim_create_autocmd({ 'VimEnter' }, {
      callback = function(data)
        local is_directory = vim.fn.isdirectory(data.file) == 1

        -- Return early if we're not in a directory
        if not is_directory then
          return
        end

        -- Create a new empty buffer
        vim.cmd.enew()

        -- Open the tree
        require('nvim-tree.api').tree.open({ focus = false, find_file = true })
      end
    })
  end
}
