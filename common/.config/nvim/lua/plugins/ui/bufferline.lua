return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      options = {
        show_buffer_close_icons = true,
        show_tab_indicators = true,
        show_close_icon = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        offsets = {
          {
            text = "EXPLORER",
            filetype = "NvimTree",
            separator = true,
            text_align = "left",
          },
        },
      },
      highlights = {
        buffer_selected = {
          fg = '#e6edf3',
          bg = '#0d1117',
          bold = true,
          italic = false,
        },
        buffer_visible = {
          fg = '#7d8590',
          bg = '#161b22',
        },
        buffer = {
          fg = '#7d8590',
          bg = '#161b22',
        },
      }
    })
    -- ブラウザライクなタブナビゲーション
    vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>")
    vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>")
    -- Ctrl+x でバッファを閉じる
    vim.keymap.set('n', '<C-x>', ':bdelete<CR>', {
      silent = true,
      desc = 'Close buffer (like closing browser tab)'
    })
    -- Alt+数字でバッファを直接選択
    for i = 1, 9 do
      vim.keymap.set('n', '<A-' .. i .. '>', ':BufferLineGoToBuffer ' .. i .. '<CR>', {
        silent = true,
        desc = 'Go to buffer ' .. i
      })
    end
  end
}