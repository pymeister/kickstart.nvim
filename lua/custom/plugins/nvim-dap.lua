-- ~/.config/nvim/lua/nvim-dap.lua

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },
  },
  config = function()
    -- Require necessary modules
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Setup dap-ui
    dapui.setup()

    -- Example dap configuration for lldb (adjust as necessary)
    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode', -- Adjust to your LLDB executable
      name = 'lldb',
    }

    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    -- Key mappings for dap
    vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(
      'n',
      '<Leader>lp',
      ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>dl', ':lua require"dap".run_last()<CR>', { noremap = true, silent = true })

    -- Key mappings for dap-ui
    vim.api.nvim_set_keymap('n', '<Leader>du', ':lua require"dapui".toggle()<CR>', { noremap = true, silent = true })

    -- Auto open/close dap-ui when debugging starts/ends
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Optional debug print to check dapui state
    -- print(vim.inspect(dapui))
  end,
  opts = {},
}
