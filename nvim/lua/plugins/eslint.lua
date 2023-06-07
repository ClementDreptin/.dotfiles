return {
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectory = { mode = 'auto' },
        },
      },
    },
  },
}
