return {
  'nvim-neorg/neorg',
  dependencies = { 'luarocks.nvim' },
  version = '*',
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              neorg = '~/neorg',
            },
            default_workspace = 'neorg',
          },
        },
      },
    }

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
