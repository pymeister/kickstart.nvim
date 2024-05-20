return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    {
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle',
    },
    'lewis6991/spellsitter.nvim',
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'python',
        'java',
        'lua',
        'javascript',
        'markdown',
        'markdown_inline',
        'regex',
        'json',
        'yaml',
        'toml',
        'bash',
        'html',
        'css',
        'gitignore',
        'sql',
        'rust',
        'go',
        'graphql',
        'dockerfile',
        'vim',
        'vimdoc',
        'git_rebase',
      },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- Add this line
      },
      playground = { enable = true },
      context_commentstring = { enable = true },
      autotag = { enable = true },
      additional_vim_regex_highlighting = { 'python' },
      indent = { enable = true, disable = { 'python' } },
    }
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.configs').setup(opts)
  end,
}
