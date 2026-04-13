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

vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
]])

vim.cmd('highlight Normal ctermbg=234')

