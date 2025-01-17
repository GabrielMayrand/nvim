return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          javascript = { "prettierd", stop_after_first = true },
          typescript = { "prettierd", stop_after_first = true },
          vue = { "prettierd", stop_after_first = true },
          css = { "prettierd", stop_after_first = true },
          html = { "prettierd", stop_after_first = true },
          scss = { "prettierd", stop_after_first = true },
        },
      })
    end,
  },
}
