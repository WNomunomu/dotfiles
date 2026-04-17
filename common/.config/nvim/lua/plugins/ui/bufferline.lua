return {
  'akinsho/bufferline.nvim',
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
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
    -- Ctrl+x でバッファを閉じる (VSCode風: 隣のタブに遷移、最後の1つなら enew)
    vim.keymap.set('n', '<C-x>', function()
      local bufs = vim.tbl_filter(function(b)
        return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
      end, vim.api.nvim_list_bufs())
      local cur = vim.api.nvim_get_current_buf()
      if #bufs <= 1 then
        vim.cmd('enew')
        if vim.api.nvim_buf_is_valid(cur) then
          vim.api.nvim_buf_delete(cur, { force = true })
        end
      else
        vim.cmd('BufferLineCyclePrev')
        vim.api.nvim_buf_delete(cur, { force = false })
      end
    end, {
      silent = true,
      desc = 'Close buffer (like closing VS Code tab)'
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