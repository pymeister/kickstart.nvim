return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    {
      'mfussenegger/nvim-dap-python',
      ft = { 'python' },
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
    dap.adapters.python = {
      type = 'executable',
      command = '/Users/kermitfrog19/.virtualenvs/debugpy/bin/python',
      args = { '-m', 'debugpy.adapter' },
    }

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          return '/Users/kermitfrog19/.virtualenvs/debugpy/bin/python'
        end,
      },
    }

    dap.listeners.after['event_initialized.python'] = function()
      print 'dap initialized'
    end

    dap.listeners.after['event_terminated.python'] = function()
      print 'dap terminated'
    end

    dap.listeners.before['event_terminated.python'] = function()
      print 'dap terminated'
    end

    dap.listeners.before['event_exited.python'] = function()
      print 'dap exited'
    end

    dap.listeners.before['event_stopped.python'] = function()
      print 'stopped'
    end

    dap.adapters.django = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'dap.adapters.django' },
    }

    dap.configurations.django = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch Django',
        module = 'manage',
        args = { 'runserver', '--noreload' },
        django = true,
      },
    }

    vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dm', '<cmd>lua require("dap-python").test_method()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua require("dap-python").test_class()<CR>', { noremap = true, silent = true })
  end,
}
