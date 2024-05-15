return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup()
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode' },
      ['<leader>d'] = { name = '[D]ocument' },
      ['<leader>r'] = { name = '[R]ename' },
      ['<leader>s'] = { name = '[S]earch' },
      ['<leader>w'] = { name = '[W]orkspace' },
      ['<leader>t'] = { name = '[T]oggle' },
      ['<leader>h'] = { name = 'Git [H]unk' },
    }
    require('which-key').register({
      ['<leader>h'] = { 'Git [H]unk' },
    }, { mode = 'v' })
  end,
}
