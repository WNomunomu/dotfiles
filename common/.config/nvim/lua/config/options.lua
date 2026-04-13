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
