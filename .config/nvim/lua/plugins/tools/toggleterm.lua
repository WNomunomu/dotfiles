return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>to", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  config = function()
    require("toggleterm").setup({
      size = 100,
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
    })

    -- ターミナルモードでのキーマッピング
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-c>", [[<C-\><C-n>:ToggleTerm<CR>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}