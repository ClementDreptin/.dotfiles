-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Display line numbers
vim.wo.number = true

-- Allow to use the mouse
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim
vim.o.clipboard = 'unnamedplus'

-- Disable line wrap
vim.o.wrap = false

-- Indentation
vim.o.tabstop = 8 -- Set tab characters width to 8 to that I immediately notice when a tab character is inserted
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true -- Convert tabs to spaces

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true
