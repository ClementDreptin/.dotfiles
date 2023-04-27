return {
  'hrsh7th/nvim-cmp',
  opts = {
    -- Disable autocomplete in comments
    enabled = function()
      local in_comment = require('cmp.config.context').in_treesitter_capture('comment') == true
        or require('cmp.config.context').in_syntax_group('Comment')

      return not in_comment
    end,
  },
}
