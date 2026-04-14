require('config.options')
require('config.keymap')
require('config.lazy')

vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = '/usr/local/bin/win32yank.exe -i --crlf',
      ['*'] = '/usr/local/bin/win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = '/usr/local/bin/win32yank.exe -o --lf',
      ['*'] = '/usr/local/bin/win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end

vim.api.nvim_create_autocmd('VimLeave', {
  callback = function()
    vim.opt.guicursor = 'a:ver25'
  end,
})

-- Alacritty の github_dark_tritanopia テーマに合わせたターミナルカラー
-- nvim 内蔵ターミナル (lazygit 等) で Alacritty と同じ色を使うため
vim.g.terminal_color_0  = '#484f58'  -- black
vim.g.terminal_color_1  = '#ff7b72'  -- red
vim.g.terminal_color_2  = '#58a6ff'  -- green
vim.g.terminal_color_3  = '#d29922'  -- yellow
vim.g.terminal_color_4  = '#58a6ff'  -- blue
vim.g.terminal_color_5  = '#bc8cff'  -- magenta
vim.g.terminal_color_6  = '#39c5cf'  -- cyan
vim.g.terminal_color_7  = '#b1bac4'  -- white
vim.g.terminal_color_8  = '#6e7681'  -- bright black
vim.g.terminal_color_9  = '#ffa198'  -- bright red
vim.g.terminal_color_10 = '#79c0ff'  -- bright green
vim.g.terminal_color_11 = '#e3b341'  -- bright yellow
vim.g.terminal_color_12 = '#79c0ff'  -- bright blue
vim.g.terminal_color_13 = '#bc8cff'  -- bright magenta
vim.g.terminal_color_14 = '#39c5cf'  -- bright cyan
vim.g.terminal_color_15 = '#b1bac4'  -- bright white

vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
]])

vim.cmd('highlight Normal ctermbg=234')

