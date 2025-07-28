-- ============================================================================
-- BASIC KEYMAPS
-- ============================================================================

-- CONFIG & RELOAD
vim.keymap.set('n', '<leader>rr', ':source $MYVIMRC<CR>', { desc = 'Reload config' })
vim.keymap.set('n', '<leader>rc', ':e ~/.config/nvim/init.lua<CR>', { desc = 'Edit config' })

-- SEARCH & NAVIGATION
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- EDITING & TEXT MANIPULATION
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position' })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- BUFFER MANAGEMENT
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

-- LINE & SELECTION MOVEMENT
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', { desc = 'Move selection up' })
-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Window splitting
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Split window horizontally' })

-- Window resizing
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })




-- FILE OPERATIONS
-- ============================================================================
-- ============================================================================

-- Copy full file path for the current file
vim.keymap.set("n", "<leader>fp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = 'Copy full file path' })

-- ============================================================================
-- MARKDOWN
-- ============================================================================

-- Checkbox toggle 
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set('n', '<leader>cc', function()
      local line = vim.api.nvim_get_current_line()
      local new_line = line:gsub("^(%s*%- )%[(.-)%]", function(prefix, state)
        return prefix .. (state == " " and "[x]" or "[ ]")
      end)
      vim.api.nvim_set_current_line(new_line)
    end, { desc = 'Toggle markdown checkbox', buffer = true })
  end,
})
