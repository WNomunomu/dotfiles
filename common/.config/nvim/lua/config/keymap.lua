local keymap = vim.keymap.set

-- 基本キーマップ
keymap('i', 'jj', '<Esc>', { silent = true })

keymap('n', '<C-a>', 'ggVG', { silent = true })
keymap('n', '<leader>m', '<cmd>Mason<cr>', {})

-- ターミナルモード内でも Ctrl-w + hjkl でウィンドウ移動できるようにする
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j", { desc = "Move to lower window" })
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k", { desc = "Move to upper window" })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })

-- LSPキーマップ

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    -- keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})
