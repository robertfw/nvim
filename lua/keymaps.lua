local function norm(left, right, description)
  vim.keymap.set('n', left, right, { desc = description })
end

local function leader(left, right, description)
  norm('<leader>' .. left, right, description)
end

-- [ Top Level General Utility Keybinds ]
-- Clear highlight if hitting esc in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- [ Insert mode mappings ]
-- jj for escape, jk to escape and write
vim.keymap.set('i', 'jj', '<Esc>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>:w<cr>')
-- hh to accept auto complete
vim.keymap.set('i', 'hh', '<Cmd>lua require("blink.cmp").accept()<CR>')

-- Keybinds to make split navigation easier.
norm('<C-h>', '<C-w><C-h>', 'Focus left')
norm('<C-j>', '<C-w><C-j>', 'Focus down')
norm('<C-k>', '<C-w><C-k>', 'Focus up')
norm('<C-l>', '<C-w><C-l>', 'Focus right')

-- [ Anything under <leader> ]

leader('q', vim.diagnostic.setloclist, 'Quickfix')

-- Files
leader('fs', '<Cmd>w<CR>', 'Write')
leader('ff', '<Cmd>lua require("telescope.builtin").find_files()<CR>', 'Find')
leader('fh', '<Cmd>lua require("telescope.builtin").find_files({hidden = true})<CR>', 'Find (including hidden)')

-- Buffers
leader('<tab>', '<Cmd>b#<CR>', 'Last buffer')
leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>', 'Delete')
leader('bo', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and buf ~= current then
      MiniBufremove.delete(buf)
    end
  end
end, 'Delete all other buffers')
leader('bD', function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      MiniBufremove.delete(buf)
    end
  end
end, 'Delete all buffers')

-- Windows
leader('wH', '<C-w>H', 'Move left')
leader('wJ', '<C-w>J', 'Move bottom')
leader('wK', '<C-w>K', 'Move top ')
leader('wL', '<C-w>L', 'Move right')
leader('ws', '<C-w>s', 'Split horizontal')
leader('wv', '<C-w>v', 'Split vertical')
leader('wq', '<C-w>q', 'Quit')
leader('wO', '<C-w>o', 'Close all other windows')
leader('wT', '<C-w>T', 'Break out into new tab')
leader('wh', '<C-w><C-h>', 'Focus left')
leader('wj', '<C-w><C-h>', 'Focus down')
leader('wk', '<C-w><C-h>', 'Focus up')
leader('wl', '<C-w><C-h>', 'Focus right')

-- Utilities
-- Execute a command, and then copy the output into the clipboard
local function execute_then_put()
  local cmd = vim.fn.input(':', '', 'command')
  if cmd == '' then
    return
  end

  local out = vim.trim(vim.api.nvim_exec2(cmd, { output = true }).output)
  vim.fn.setreg('+', out)
end
vim.keymap.set('n', '<leader>ux', execute_then_put, { desc = 'Execute command and copy output', silent = true })

-- insert a uuid4
-- requires uuidgen, which should be available by default on linux/osx
local function insert_uuid4()
  local uuid = vim.fn.system('uuidgen'):gsub('\n', '')
  vim.api.nvim_put({ uuid }, 'c', true, true)
end
vim.keymap.set('n', '<leader>uu', insert_uuid4, { desc = 'Insert UUID4' })
