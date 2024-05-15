-- Define a Lua module named 'rename'
local M = {}

-- Function to perform variable renaming
local function rename_variable()
  -- Get the current word under the cursor
  local current_word = vim.fn.expand '<cword>'

  -- Prompt the user for the new name
  local new_name = vim.fn.input('New name: ', current_word)

  -- Perform the rename if a new name is provided
  if new_name and #new_name > 0 then
    -- Execute the substitution command to rename the variable
    vim.cmd('s/\\<' .. current_word .. '\\>/' .. new_name .. '/gc')
  end
end

-- Function to set up key mappings for renaming
function M.setup()
  -- Define the keymap for triggering the rename function
  vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua require"rename".rename_variable()<CR>', { noremap = true, silent = true })
end

-- Export the module
return M
