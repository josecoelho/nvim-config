local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    typescript = {{ "prettierd", "prettier" }},
    javascript = {{ "prettierd", "prettier" }},
    terraform = {"tflint"},


  },

  format_after_save = {
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
