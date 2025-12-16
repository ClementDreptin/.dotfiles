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

-- Options specific to markdown files
local markdown_options = {
  "wrap",
  "linebreak",
}
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md" },
  callback = function()
    for _, option_name in pairs(markdown_options) do
      opt[option_name] = true
    end
  end,
})
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = { "*.md" },
  callback = function()
    for _, option_name in pairs(markdown_options) do
      opt[option_name] = false
    end
  end,
})
