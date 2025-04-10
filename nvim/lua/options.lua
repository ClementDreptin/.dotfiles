-- Shortcuts for conciseness
local opt = vim.opt
local g = vim.g

-- Set leader key to space
g.mapleader = " "

-- Display line numbers
opt.number = true

-- Sync with system clipboard
opt.clipboard = "unnamedplus"

-- Always show sign column so that text doesn't shift
opt.signcolumn = "yes"

-- Indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- Expand tab to spaces
opt.autoindent = true -- Copy indent from current line when starting new one

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- If the search includes a mixed case, assume the search to be case-sensitive

-- Enable line wrapping and spell check but only for markdown files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md" },
  callback = function()
    opt.wrap = true
    opt.spell = true
  end,
})
