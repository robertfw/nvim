return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_enable_italic = true
      -- vim.cmd.colorscheme 'sonokai'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
