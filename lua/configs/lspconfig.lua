local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

nvlsp.defaults() -- loads nvchad's defaults

local servers = { "html", "cssls", "ts_ls", "clangd", "pyright", "terraformls", "eslint" }

-- on_attach function for lspconfig
-- mappings need to be here because they are lazy loaded
local on_attach = function(client, bufnr)
  local map = vim.keymap.set
  nvlsp.on_attach(client, bufnr)
  vim.keymap.set("n", "gd", "<cmd> Telescope<cr>", { buffer = bufnr })

  -- LSP mappings with Telescope
  map("n", "gd", function()
    require("telescope.builtin").lsp_definitions()
  end, { desc = "LSP definitions" })
  map("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, { desc = "LSP references" })
  map("n", "gi", function()
    require("telescope.builtin").lsp_implementations()
  end, { desc = "LSP implementations" })
  map("n", "gt", function()
    require("telescope.builtin").lsp_type_definitions()
  end, { desc = "LSP type definitions" })
  map("n", "<leader>ls", function()
    require("telescope.builtin").lsp_document_symbols()
  end, { desc = "Document symbols" })
  map("n", "<leader>lS", function()
    require("telescope.builtin").lsp_workspace_symbols()
  end, { desc = "Workspace symbols" })
  map("n", "<leader>ld", function()
    require("telescope.builtin").diagnostics()
  end, { desc = "Diagnostics" })
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Solargraph configuration for Rails
lspconfig.solargraph.setup {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
      formatting = true,
      useBundler = true, -- Use bundle exec solargraph if true
      autoformat = true,
      folding = true,
      checkGemVersion = true,
      references = true,
      rename = true,
      symbols = true,
    },
  },
  filetypes = { "ruby", "rakefile", "rb", "erb" },
}
