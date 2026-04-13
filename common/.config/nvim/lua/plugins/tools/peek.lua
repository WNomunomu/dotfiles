return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  config = function()
      require("peek").setup({
        app = "browser",
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      vim.keymap.set('n', '<leader>mo', require("peek").open, { desc = "Peek Open" })
      vim.keymap.set('n', '<leader>mc', require("peek").close, { desc = "Peek Close" })
  end,
}