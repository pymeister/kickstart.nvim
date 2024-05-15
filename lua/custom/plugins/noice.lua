return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = function(_, opts)
    -- Ensure opts.routes is initialized as an empty table if it's nil
    opts.routes = opts.routes or {}

    table.insert(opts.routes, {
      filter = {
        event = 'notify',
        find = 'No information available',
      },
      opts = { skip = true },
    })
    local focused = true
    vim.api.nvim_create_autocmd('FocusGained', {
      callback = function()
        focused = true
      end,
    })
    vim.api.nvim_create_autocmd('FocusLost', {
      callback = function()
        focused = false
      end,
    })
    table.insert(opts.routes, 1, {
      filter = {
        cond = function()
          return not focused
        end,
      },
      view = 'notify_send',
      opts = { stop = false },
    })

    opts.commands = {
      all = {
        -- options for the message history that you get with `:Noice`
        view = 'split',
        opts = { enter = true, format = 'details' },
        filter = {},
      },
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(event)
        vim.schedule(function()
          require('noice.text.markdown').keys(event.buf)
        end)
      end,
    })

    opts.presets = opts.presets or {}
    opts.presets.lsp_doc_border = true

    return opts
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
}
