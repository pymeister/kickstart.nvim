vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
vim.g.have_nerd_font = true

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
        vim.cmd([[hi NonText guibg=NONE ctermbg=NONE]])
        vim.cmd([[hi NeoTreeNormal guibg=NONE ctermbg=NONE]])
        vim.cmd([[hi NeoTreeNormalNC guibg=NONE ctermbg=NONE]])
        vim.cmd([[hi NvimTreeNormal guibg=NONE]])
        vim.cmd([[hi StatusLine guibg=NONE]])
        vim.cmd([[hi StatusLineNC guibg=NONE]])
    end,
})

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<space>fb', function()
    require('telescope').extensions.file_browser.file_browser()
end)

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_user_command('DashboardNewFile', 'enew', {})

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'tpope/vim-sleuth',

    {
        'jose-elias-alvarez/null-ls.nvim',
        ft = { 'python' },
        opts = function()
            local null_ls = require 'null-ls'
            local sources = {
                null_ls.builtins.formatting.black.with {
                    command = 'black',
                },
                null_ls.builtins.diagnostics.ruff.with {
                    command = 'ruff',
                },
            }
            return {
                sources = sources,
            }
        end,
    },
    
    -- Debugging configurations
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    
    {
        "mfussenegger/nvim-dap",
        config = function(_, opts)
            require("core.utils").load_mappings("dap")
        end,
    },
    
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
            require("core.utils").load_mappings("dap_python")
        end,
    },
    
    'tweekmonster/django-plus.vim',
    'numToStr/Comment.nvim',

    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        config = function()
            require('which-key').setup()
            require('which-key').register({
                ['<leader>c'] = { name = '[C]ode' },
                ['<leader>d'] = { name = '[D]ocument' },
                ['<leader>r'] = { name = '[R]ename' },
                ['<leader>s'] = { name = '[S]earch' },
                ['<leader>w'] = { name = '[W]orkspace' },
                ['<leader>t'] = { name = '[T]oggle' },
                ['<leader>h'] = { name = 'Git [H]unk' },
            })
            require('which-key').register({
                ['<leader>h'] = { 'Git [H]unk' },
            }, { mode = 'v' })
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable('make') == 1
                end,
            },
            {
                'nvim-telescope/telescope-ui-select.nvim',
            },
            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font,
            },
        },
        config = function()
            require('telescope').setup({
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            })
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
            vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[F]ind [C]ommands' })
            vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, { desc = '[F]ind [S]pelling Suggestion' })
        end,
    },

    'ThePrimeagen/harpoon',
    'eandrju/cellular-automaton.nvim',
    'ellisonleao/glow.nvim',
    'nvim-neotest/neotest',
    'folke/todo-comments.nvim',

    {
        'nvim-neotest/neotest-python',
        ft = 'python',
        dependencies = { 'nvim-neotest/neotest' },
    },

    {
        'nvim-neotest/neotest-vim-test',
        dependencies = {
            'nvim-neotest/neotest',
            'vim-test/vim-test',
        },
        ft = 'python',
    },
    
    {
        'lewis6991/spellsitter.nvim',
        ft = { 'python', 'markdown' },
        opts = {
            enable = true,
        },
    },

    {
        'vim-test/vim-test',
        config = function()
            local test = vim.g
            test['test#strategy'] = 'neovim'
        end,
        ft = 'python',
    },

    {
        'davidgranstrom/nvim-markdown-preview',
        ft = 'markdown',
        config = function()
            vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<CR>', { desc = '[M]arkdown [P]review' })
            vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<CR>', { desc = '[M]arkdown [S]top' })
        end,
    },

    {
        'dhruvasagar/vim-table-mode',
        ft = { 'markdown', 'text', 'plain', 'wiki' },
        config = function()
            vim.g.table_mode_corner = '|'
            vim.g.table_mode_header_fillchar = '='
            vim.g.table_mode_header_fillchar_below = true
        end,
    },

    {
        'm4xshen/autoclose.nvim',
        config = function()
            require('autoclose').setup()
        end,
    },

    {
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
                            padding = {
                                right = 1,
                            },
                        },
                    },
                    lualine_z = {
                        {
                            'location',
                            padding = {
                                left = 0,
                            },
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
    },

    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup()
            require('telescope').load_extension 'projects'
        end,
    },

    

    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            {
                'nvim-treesitter/playground',
                cmd = 'TSPlaygroundToggle',
            },
            'lewis6991/spellsitter.nvim',
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'python',
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
                },
                playground = {
                    enable = true,
                },
                context_commentstring = {
                    enable = true,
                },
                autotag = {
                    enable = true,
                },
            })
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v',
                            ['@function.outer'] = 'V',
                            ['@class.outer'] = 'V',
                        },
                        include_surrounding_whitespace = true,
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']]'] = '@function.outer',
                            [']c'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']['] = '@function.outer',
                            [']C'] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[['] = '@function.outer',
                            ['[c'] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[]'] = '@function.outer',
                            ['[C'] = '@class.outer',
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = 'none',
                        peek_definition_code = {
                            ['<leader>df'] = '@function.outer',
                            ['<leader>dF'] = '@class.outer',
                        },
                    },
                },
            })
        end,
    },


  -- Additional plugins from the kickstart repository
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',

  -- Custom plugin imports

  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
