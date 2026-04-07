return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gdm', '<cmd>DiffviewOpen main<cr>', desc = 'Main' },
    { '<leader>gdc', '<cmd>DiffviewClose<cr>', desc = 'Close diffview' },
  },
}
