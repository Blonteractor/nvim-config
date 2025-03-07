---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "everforest",
  theme_toggle = { "github_light", "everforest" },
  lsp_semantic_tokens = true,
  transparency = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = true,
    header = {
      "██████╗ ██╗      ██████╗ ███╗   ██╗",
      "██╔══██╗██║     ██╔═══██╗████╗  ██║",
      "██████╔╝██║     ██║   ██║██╔██╗ ██║",
      "██╔═══╝ ██║     ██║   ██║██║╚██╗██║",
      "██║     ███████╗╚██████╔╝██║ ╚████║",
      "╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝",
    }

  },

  tabufline = {
    enabled = false
  },

  lsp = {
    signature = {
      silent = true,
      disabled = false,
    }
  },

  statusline = {
    disabled = true
  }
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = "LspAttach_inlayhints",
--   callback = function(args)
--     if not (args.data and args.data.client_id) then
--       return
--     end
--
--     local bufnr = args.buf
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     require("lsp-inlayhints").on_attach(client, bufnr)
--   end,
-- })

return M
