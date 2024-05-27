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
  "rust_analyzer"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>od', function()
      client.request('experimental/externalDocs', vim.lsp.util.make_position_params(), function(_, url)
        vim.fn.jobstart(string.format("open %s", url))
      end, vim.api.nvim_get_current_buf())
    end, { noremap = true, silent = true })

    on_attach(client, bufnr)
  end,
}

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
