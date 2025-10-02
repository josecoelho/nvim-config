local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

nvlsp.defaults() -- loads nvchad's defaults

local servers = { "html", "cssls", "ts_ls", "clangd", "pyright", "terraformls", "eslint" }

-- on_attach function for lspconfig
-- mappings need to be here because they are lazy loaded
local on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
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
