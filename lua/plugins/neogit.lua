return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gs", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
  },
  config = function()
    require("neogit").setup()

    -- Set up buffer-local keybinding for neogit status buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NeogitStatus",
      callback = function(event)
        vim.keymap.set('n', '<leader><tab>', '<Cmd>tabprevious<CR>', {
          buffer = event.buf,
          desc = 'Previous tab'
        })
      end,
    })
  end
}
