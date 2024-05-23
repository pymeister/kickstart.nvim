return {
  -- Add dracula
  { 'Mofiqul/dracula.nvim' },

  -- Configure LazyVim to load dracula
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'dracula',
    },
    config = function()
      -- Apply the Dracula theme
      vim.cmd [[colorscheme dracula]]

      -- Make floating windows transparent
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
    end,
  },
}
