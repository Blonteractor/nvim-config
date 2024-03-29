local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "gopls",
  "sqlls",
  "dockerls",
  "zls",
  "hls",
  -- "ruff_lsp",
  "eslint",
  "pylsp",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

lspconfig.elixirls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "/opt/homebrew/bin/elixir-ls",
  },
}
--
-- lspconfig.pyright.setup { blabla}
