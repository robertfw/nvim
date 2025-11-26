vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- jj for escape, jk to escape and write
vim.keymap.set('i', 'jj', '<Esc>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>:w<cr>')

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Buffer Commands
vim.keymap.set('n', '<leader><tab>', ':b#<CR>', { desc = 'Last Buffer' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Close Buffer' })

local function execute_then_put()
  local cmd = vim.fn.input(':', '', 'command')
  if cmd == '' then
    return
  end

  local out = vim.trim(vim.api.nvim_exec2(cmd, { output = true }).output)
  vim.fn.setreg('+', out)
end
vim.keymap.set('n', '<leader>C', execute_then_put, { desc = 'Execute command and copy output', silent = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
