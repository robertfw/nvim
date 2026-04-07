-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  opts = {
    -- source_selector = {
    --   winbar = true,
    --   show_scrolled_off_parent_mode = true,
    --   sources = {
    --     {
    --       source = 'filesystem',
    --       display_name = ' 󰉓 ',
    --     },
    --     {
    --       source = 'buffers',
    --       display_name = ' 󰈚 ',
    --     },
    --     {
    --       source = 'git_status',
    --       display_name = ' 󰊢 ',
    --     },
    --     { source = 'document_symbols', display_name = ' 󰆧 ' },
    --   },
    -- },
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      'document_symbols',
    },
    event_handlers = {
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.opt_local.number = true
          vim.opt_local.relativenumber = false
        end,
      },
    },
    document_symbols = {
      follow_cursor = true,
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
