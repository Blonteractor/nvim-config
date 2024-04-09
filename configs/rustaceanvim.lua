local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require "core.utils"

local options = {
  server = {
    on_attach = function(client, bufnr)
      utils.load_mappings("rust", { buffer = bufnr })
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  },
  tools = {
    enable_clippy = false,
    inlay_hints = {
      auto = false,
    },
  },
}

return options
