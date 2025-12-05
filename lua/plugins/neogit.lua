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
  }
}
