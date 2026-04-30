return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>to", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  config = function()
    require("toggleterm").setup({
      size = 15,
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
    })

    -- ターミナルモードでのキーマッピング
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-t>", [[<C-\><C-n>:ToggleTerm<CR>]], opts)
      vim.keymap.set("t", "<C-w>h", [[<C-\><C-n><C-w>h]], opts)
      vim.keymap.set("t", "<C-w>j", [[<C-\><C-n><C-w>j]], opts)
      vim.keymap.set("t", "<C-w>k", [[<C-\><C-n><C-w>k]], opts)
      vim.keymap.set("t", "<C-w>l", [[<C-\><C-n><C-w>l]], opts)
    end

    vim.cmd("autocmd! TermOpen term://*toggleterm* lua set_terminal_keymaps()")
  end,
}
