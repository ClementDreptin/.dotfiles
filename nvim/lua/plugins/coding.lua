-- mini.move allows moving blocks of code while in visual mode
local mini_move = {
  "echasnovski/mini.move",
  opts = {
    mappings = {
      left = "<",
      right = ">",
    },
  },
}

-- mini.pairs will automatically "close" some characters
-- Example: Typing "(" will automatically insert "()" and put the cursor in the middle
local mini_pairs = {
  "echasnovski/mini.pairs",
  opts = {},
}

-- mini.surround allows surrounding a block of code selected in visual mode with characters
-- that typically go in pairs, like "()" or "{}"
local mini_surround = {
  "echasnovski/mini.surround",
  opts = {
    mappings = {
      add = "gsa",
    },
  },
}

-- nvim-ts-autotag will automatically close HTML tags (also works with JSX)
-- Example: Typing "<div>" will automatically insert "<div></div>"
local nvim_ts_autotag = {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy",
  opts = {},
}

-- ts-comments will change the type of comments inserted based on information from treesitter
-- Example: In a React component, the JS part will be commented with // but the JSX part will
-- be commented with {/**/}
local ts_comments = {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  opts = {},
}

return {
  mini_move,
  mini_pairs,
  mini_surround,
  nvim_ts_autotag,
  ts_comments,
}
