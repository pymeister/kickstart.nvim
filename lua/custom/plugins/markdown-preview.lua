return {
  'davidgranstrom/nvim-markdown-preview',
  ft = 'markdown',
  config = function()
    vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<CR>', { desc = '[M]arkdown [P]review' })
    vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<CR>', { desc = '[M]arkdown [S]top' })
  end,
}
