return {
  'vim-test/vim-test',
  config = function()
    local test = vim.g
    test['test#strategy'] = 'neovim'
  end,
  ft = 'python',
}
