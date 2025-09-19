return {
  -- テーマ
  {
    'projekt0n/github-nvim-theme',
    lazy = false,

    priority = 1000,
    config = function()
      vim.cmd('colorscheme github_dark_default')
    end,
  },

  -- ファイルエクスプローラー
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "echasnovski/mini.icons" },

  },


  -- 括弧自動補完
  {

    'windwp/nvim-autopairs',
    event = "InsertEnter",

    opts = {},
  },

  -- ファイル検索・全文検索
  {

    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
        },
      })

      -- キーマップ
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

    end,
  },

  -- LSP設定
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()

      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls", 
          "pyright",
          "clangd",
        }
      })
      
      -- 診断設定
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,

        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })


      -- 診断記号を設定
      local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- 診断のハイライト色を設定
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "Red" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "Orange" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "Blue" })

      vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "Green" })

      -- Neovim 0.11+ の新しいAPI使用
      if vim.lsp.config then
        vim.lsp.config.lua_ls = {}
        vim.lsp.config.ts_ls = {}
        vim.lsp.config.pyright = {}
        vim.lsp.config.clangd = {}
      else

        local lspconfig = require("lspconfig")
        local servers = { "lua_ls", "ts_ls", "pyright", "clangd" }
        
        for _, server in ipairs(servers) do
          lspconfig[server].setup({})
        end
      end
    end,
  },  


  -- 補完
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },
  
  -- Bufferline with browser-like tab navigation
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({
        options = {
          -- ブラウザライクな見た目のオプション
          show_buffer_close_icons = true,
          show_close_icon = true,
          separator_style = "slant", -- または "thick", "thin", "padded_slant"

          enforce_regular_tabs = false,
          always_show_bufferline = true,
        }
      })
      
      -- ブラウザライクなタブナビゲーション
      vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>")
      vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>") 
        
      -- 追加の便利なキーマップ
      -- Ctrl+w でバッファを閉じる (ブラウザのタブを閉じるのと同じ)
      vim.keymap.set('n', '<C-w>', ':bdelete<CR>', { 

        silent = true, 
        desc = 'Close buffer (like closing browser tab)' 
      })
      
      -- Alt+数字 でバッファを直接選択
      for i = 1, 9 do
        vim.keymap.set('n', '<A-' .. i .. '>', ':BufferLineGoToBuffer ' .. i .. '<CR>', { 
          silent = true, 
          desc = 'Go to buffer ' .. i 

        })
      end
    end


  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {mode = "n", "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "NvimTreeをトグルする"},
      {mode = "n", "<C-m>", "<cmd>NvimTreeFocus<CR>", desc = "NvimTreeにフォーカス"},
    },
    config = function()
      require("nvim-tree").setup {
        git = {
          enable = true,
          ignore = true,
        }
      }
    end,
  },
}

