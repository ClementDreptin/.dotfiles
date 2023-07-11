local M = {}

local to_disable = {
  'goolord/alpha-nvim',
  'stevearc/dressing.nvim',
  'rafamadriz/friendly-snippets',
  'ggandor/leap.nvim',
  'ggandor/flit.nvim',
  'folke/tokyonight.nvim',
  'dstein64/vim-startuptime',
  'lukas-reineke/indent-blankline.nvim',
  'folke/persistence.nvim',
}

for _, plugin in pairs(to_disable) do
  table.insert(M, { plugin, enabled = false })
end

return M
