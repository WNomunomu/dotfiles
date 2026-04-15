return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPre",
  config = function()
    require("git-conflict").setup({
      default_commands = true,
      disable_diagnostics = false,
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
      default_mappings = {
        ours = "co",
        theirs = "ct",
        none = "c0",
        both = "cb",
        next = "<Tab>",
        prev = "<S-Tab>",
      },
    })
  end,
}
