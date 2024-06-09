-- Bootsrap Lazy if needed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- Add Lazy to vim runtime path
vim.opt.rtp:prepend(lazypath)

require("options")
require("keymaps")

-- Make Lazy load the plugins
require("lazy").setup("plugins")
