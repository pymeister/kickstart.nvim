return {
  'jose-elias-alvarez/null-ls.nvim',
  ft = { 'python' },
  opts = function()
    local null_ls = require 'null-ls'
    local sources = {
      null_ls.builtins.formatting.black.with { command = 'black' },
      null_ls.builtins.diagnostics.ruff.with { command = 'ruff' },
    }
    return { sources = sources }
  end,
}
