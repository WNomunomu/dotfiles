return {
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
}