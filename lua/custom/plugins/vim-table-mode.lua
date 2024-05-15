return {
  'dhruvasagar/vim-table-mode',
  ft = { 'markdown', 'text', 'plain', 'wiki' },
  config = function()
    vim.g.table_mode_corner = '|'
    vim.g.table_mode_header_fillchar = '='
    vim.g.table_mode_header_fillchar_below = true
  end,
}
