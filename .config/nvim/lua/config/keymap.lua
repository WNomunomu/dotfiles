local keymap = vim.keymap.set

-- 基本キーマップ
keymap('i', 'jj', '<Esc>', { silent = true })

keymap('n', '<leader>m', '<cmd>Mason<cr>', {})

-- LSPキーマップ

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

