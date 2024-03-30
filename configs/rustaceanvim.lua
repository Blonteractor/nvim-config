local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = on_attach,
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
