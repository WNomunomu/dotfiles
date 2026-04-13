local opt = vim.opt

opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

local is_win = vim.fn.has('win32') == 1

if is_win then
  opt.softtabstop = 2
end

opt.ignorecase = true
opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>rn', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative number" })
