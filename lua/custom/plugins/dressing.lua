return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  -- Options for fzf selector
  fzf = {
    window = {
      width = 0.5,
      height = 0.4,
    },
  },

  -- Options for fzf-lua
  fzf_lua = {
    -- winopts = {
    --   height = 0.5,
    --   width = 0.5,
    -- },
  },

  -- Options for nui Menu
  nui = {
    position = '50%',
    size = nil,
    relative = 'editor',
    border = {
      style = 'rounded',
    },
    buf_options = {
      swapfile = false,
      filetype = 'DressingSelect',
    },
    win_options = {
      winblend = 0,
    },
    max_width = 80,
    max_height = 40,
    min_width = 40,
    min_height = 10,
  },
}
