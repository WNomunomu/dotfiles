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
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

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
          show_buffer_close_icons = true,
          show_tab_indicators = true,
          show_close_icon = true,
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          offsets = {
            {
              text = "EXPLORER",
              filetype = "NvimTree",
              separator = true,
              text_align = "left",
            },
          },
        },
        highlights = {
          buffer_selected = {
            fg = '#e6edf3',
            bg = '#0d1117',
            bold = true,
            italic = false,
          },
          buffer_visible = {
            fg = '#7d8590',
            bg = '#161b22',
          },
          buffer = {
            fg = '#7d8590',
            bg = '#161b22',
          },
        }
      })
      -- ブラウザライクなタブナビゲーション
      vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>")
      vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>") 
      -- Ctrl+x でバッファを閉じる
      vim.keymap.set('n', '<C-x>', ':bdelete<CR>', { 
        silent = true, 
        desc = 'Close buffer (like closing browser tab)' 
      })
      -- Alt+数字でバッファを直接選択
      for i = 1, 9 do
        vim.keymap.set('n', '<A-' .. i .. '>', ':BufferLineGoToBuffer ' .. i .. '<CR>', { 
          silent = true, 
          desc = 'Go to buffer ' .. i 
        })
      end
    end
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = true,
        git_cmd = { "git" },
        use_icons = true,
      })
    end,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
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
      {mode = "n", "<leader>ff", "<cmd>NvimTreeFindFile<CR>", desc = "NvimTreeで編集中のファイルに飛ぶ"},
    },
    config = function()
      require("nvim-tree").setup {
        filters = {
          git_ignored = false,
        },
        git = {
          enable = true,
          timeout = 5000,
          show_on_dirs = true,
          show_on_open_dirs = false,
        },
        renderer = {
          indent_width = 1,
          icons = {
            show = {
              git = true,
            },
            git_placement = "before",
            glyphs = {
              git = {
                unstaged = "M",   -- Modified (unstaged)
                staged = "A",     -- Added/staged
                unmerged = "C",   -- Unmerged
                renamed = "R",    -- Renamed
                untracked = "U", -- Untracked
                deleted = "D",    -- Deleted
                ignored = "!"     -- Ignored
              }
            }
          },
          highlight_git = true,
          highlight_opened_files = "name",
        },
        view = {
          width = 35,
        },
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'nightfly',
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- List of parsers to install
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "python",
          "html",
          "css",
          "tsx",
          "vue",
          "ruby",
          "cpp",
          "c",
          "java",
          "kotlin",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        }
      })
    end,
  },
}

