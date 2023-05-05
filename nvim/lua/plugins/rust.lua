return {
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            -- Run cargo clippy instead of cargo check
            check = {
              overrideCommand = {
                'cargo',
                'clippy',
                '--workspace',
                '--message-format=json',
                '--all-targets',
                '--all-features',
              },
            },
          },
        },
      },
    },
  },
}
