require('config.options')
require('config.keymap')
require('plugins')
require('config.lazy')
require('oil').setup()

vim.opt.clipboard = "unnamedplus"

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

