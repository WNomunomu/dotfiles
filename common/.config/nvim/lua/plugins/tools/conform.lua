return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
