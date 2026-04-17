return {
  'projekt0n/github-nvim-theme',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme github_dark_default')
    -- diffview で削除行が赤く表示されるようにする
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#3d1e28', fg = '#ff7b72' })
    -- vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#1a2e1f', fg = '#58a6ff' })
    -- vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#272d1d' })
    -- vim.api.nvim_set_hl(0, 'DiffText', { bg = '#3b4228' })
    vim.api.nvim_set_hl(0, 'DiffviewDiffAddAsDelete', { bg = '#3d1e28' })
    vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { fg = '#6e7681' })
  end,
}
