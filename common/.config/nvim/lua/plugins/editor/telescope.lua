return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = "Telescope",
  keys = {
    { '<C-p>', function() require('telescope.builtin').find_files() end, desc = "Find files" },
    { '<C-f>', function() require('telescope.builtin').live_grep() end, desc = "Live grep" },
    { '<leader>fr', function() require('telescope.builtin').live_grep({ additional_args = {} }) end, desc = "Live grep (regex)" },
    { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = "Buffers" },
  },
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

  end,
}
