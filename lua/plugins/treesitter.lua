-- Neovim 0.12+ has built-in treesitter support (highlighting, indent, parser management).
-- The nvim-treesitter plugin was archived April 2026 and is no longer needed.
-- Install parsers with the built-in :TSInstall command.

return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      -- Disable for markdown: treesitter-context crashes with 'range' (a nil value)
      -- when traversing injected language trees in markdown code blocks.
      on_attach = function(buf)
        return vim.bo[buf].filetype ~= 'markdown'
      end,
    },
  },
}
