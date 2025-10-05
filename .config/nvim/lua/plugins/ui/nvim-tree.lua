return {
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
}