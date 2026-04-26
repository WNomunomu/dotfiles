return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  event = { "BufReadPost", "BufNewFile" },
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
        "go",
        "gomod",
        "gosum",
        "terraform",
        "hcl",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      }
    })
  end,
}
