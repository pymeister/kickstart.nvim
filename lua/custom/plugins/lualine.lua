return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = vim.g.have_nerd_font,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          'NvimTree',
          'neo-tree',
          'dashboard',
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = '', warn = '', info = '' },
          },
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = {
          {
            'progress',
            separator = '',
            padding = { right = 1 },
          },
        },
        lualine_z = {
          {
            'location',
            padding = { left = 0 },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'nvim-tree' },
    }
  end,
}
