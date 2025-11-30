return {
  "lervag/vimtex",
  lazy = false,
  config = function()
    -- PDF viewer: SumatraPDF (WSL環境)
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe'
    vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'

    -- コンパイラ設定（自動コンパイル有効）
    vim.g.vimtex_compiler_latexmk = {
      build_dir = '',
      callback = 1,
      continuous = 1,  -- 保存時に自動コンパイル
      executable = 'latexmk',
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
        '-pdf',
      },
    }

    -- エラー表示の設定
    vim.g.vimtex_quickfix_mode = 0

    -- TOC（目次）の設定
    vim.g.vimtex_toc_config = {
      name = 'TOC',
      layers = {'content', 'todo', 'include'},
      split_width = 25,
      todo_sorted = 0,
      show_help = 1,
      show_numbers = 1,
    }

    -- コンパイラのクリーンアップ設定
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = '-pdf'
    }

    -- Forward searchのキーマップ（オプション）
    vim.keymap.set('n', '<localleader>lv', '<cmd>VimtexView<CR>', { desc = 'VimTeX: View PDF' })
  end,
}

