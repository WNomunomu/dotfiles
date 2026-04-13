return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        file_ignore_patterns = {
          "%.git",
          "node_modules"
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = { "--fixed-strings" }, -- デフォルトで正規表現無効（リテラル検索）
        },
      },
    })

    -- キーマップ
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fr', function()
      builtin.live_grep({ additional_args = {} })
    end, { desc = "Live grep (regex)" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  end,
}
