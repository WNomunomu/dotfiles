return {
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
}