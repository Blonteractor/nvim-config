local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  -- "tsserver",
  "gopls",
  "sqlls",
  "dockerls",
  "zls",
  "hls",
  -- "ruff_lsp",
  "eslint",
  "pyright",
  -- "rust_analyzer",
  -- "typst_lsp",
  "ts_ls",
  "wgsl_analyzer"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.rust_analyzer.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name

    if path == '/Users/priyanshu/dev/aftershoot/backend' then
      client.config.settings["rust-analyzer"].cargo.features = { "editing", "culling", "dbmigration" }
      client.config.settings["rust-analyzer"].cargo.default_features = false
    end

    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    return true
  end,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>od', function()
      client.request('experimental/externalDocs', vim.lsp.util.make_position_params(), function(_, url)
        vim.fn.jobstart(string.format("open %s", url))
      end, vim.api.nvim_get_current_buf())
    end, { noremap = true, silent = true })

    on_attach(client, bufnr)
  end,
  settings = {
    ['rust-analyzer'] = {
      cargo = { features = {} },
      diagnostic = {
        refresh_support = false,
      }
    }
  }
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
