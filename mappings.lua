---@type MappingsTable
local M = {}

M.lspconfig = {
  plugin = true,

  n = {
    ["gd"] = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "LSP definition"
    },

    ["gr"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "LSP definition"
    },

    ["<leader>ds"] = {
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "LSP document symbols"
    },

    ["<leader>ws"] = {
      function()
        require("telescope.builtin").lsp_workspace_symbols()
      end,
      "LSP document symbols"
    },

    ["gt"] = {
      function()
        require("telescope.builtin").lsp_type_definitions()
      end,
      "LSP peek definition"
    },
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-d>"] = { "<C-d>zz", opts = { nowait = true } },
    ["<C-u>"] = { "<C-u>zz", opts = { nowait = true } },

    ["n"] = { "nzz", opts = { nowait = true } },
    ["N"] = { "Nzz", opts = { nowait = true } },
  },
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function()
        require("crates").upgrade_all_crates()
      end,
      "Update crates",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

-- more keybinds!

M.trouble = {
  n = {
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "toggle diagnostics", opts = { silent = true, noremap = true } },
    ["<leader>xw"] = {
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      "toggle workspace diagnostics",
      opts = { silent = true, noremap = true },
    },
    ["<leader>xd"] = {
      "<cmd>TroubleToggle document_diagnostics<cr>",
      "toggle document diagnostics",
      opts = { silent = true, noremap = true },
    },
    ["<leader>xl"] = {
      "<cmd>TroubleToggle loclist<cr>",
      "toggle loclist",
      opts = { silent = true, noremap = true },
    },
    ["<leader>xq"] = {
      "<cmd>TroubleToggle quickfix<cr>",
      "toggle quick fixes",
      opts = { silent = true, noremap = true },
    },
    ["gR"] = {
      "<cmd>TroubleToggle lsp_references<cr>",
      "toggle lsp refrences",
      opts = { silent = true, noremap = true },
    },
  },
}

M.compiler = {
  n = {
    ["<F6>"] = { "<cmd>CompilerOpen<cr>", "Open compiler", opts = { silent = true, noremap = true } },
    ["S-<F6>"] = { "<cmd>CompilerToggleResults<cr>", "Toggle output resume", opts = { silent = true, noremap = true } },
  },
}

M.gitsigns = {
  n = {
    ["<leader>lg"] = { "<cmd>LazyGit<cr>", "Open lazygit", opts = { silent = true, noremap = true } },
  },
}

-- M.lines = {
--   n = {
--     ["<leader>l"] = { require("lsp_lines").toggle, "toggle lsp lines", opts = { silent = true, noremap = true } },
--   },
-- }
--
return M
