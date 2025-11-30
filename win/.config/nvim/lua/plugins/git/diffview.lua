return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = true,
      git_cmd = { "git" },
      use_icons = true,
    })
  end,
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
}