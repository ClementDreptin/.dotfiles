return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    pcall(require('nvim-treesitter.install').update({ with_sync = true }))

    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'c', 'cpp', 'lua' },
      auto_install = true,
      highlight = {
        enable = true,
      },
    })
  end,
}
