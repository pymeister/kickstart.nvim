return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    -- Import comment plugin safely
    local comment = require 'Comment'

    -- Import ts_context_commentstring and setup
    local ts_context_commentstring = require 'ts_context_commentstring'
    ts_context_commentstring.setup {}

    -- Enable comment
    comment.setup {
      -- For commenting tsx, jsx, svelte, html files
      pre_hook = nil,
    }
  end,
}
