local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  { "NvChad/nvim-colorizer.lua", enabled = false },

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      autoformat = true,
      inlay_hints = {
        enabled = false,
      },
    },

    dependencies = {
      "stevearc/conform.nvim",
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    cmd = { "ConformInfo" },
    opts = {
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    ft = { "rust", "toml" },
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },

  {
    "andweeb/presence.nvim",
    lazy = false,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },

  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, { name = crates })
      return M
    end,
  },

  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = false,
      leader_key = '-',        -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
    },
    config = function(_, opts)
      require("arrow").setup(opts)
    end,
    lazy = false,
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    opts = {
      change_directory_command = "cd",
      update_on_change = true,
      update_on_change_command = "e .",
      clearjumps_on_change = true,
      autopush = false
    },
    config = function(_, opts)
      require("git-worktree").setup(opts)
      require("telescope").load_extension("git_worktree")
    end,
    lazy = false,
    dependencies = "nvim-telescope/telescope.nvim"
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function(_, _)
      require("todo-comments").setup()
    end
  },

  {
    "IndianBoy42/tree-sitter-just",
    ft = "just",
    dependencies = "nvim-treesitter/nvim-treesitter",

    config = function(_)
      require("nvim-treesitter.parsers").get_parser_configs().just = {
        install_info = {
          url = "https://github.com/IndianBoy42/tree-sitter-just",
          files = { "src/parser.c", "src/scanner.cc" },
          branch = "main",
          use_makefile = true, -- necessay on macos-- this may be necessary on MacOS (try if you see compiler errors)
        },
        maintainers = { "@IndianBoy42" },
      }
    end,
  },

  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   lazy = false,
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- },

  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^4',
  --   ft = { 'rust' },
  --   config = function()
  --     vim.g.rustaceanvim = require("custom.configs.rustaceanvim")
  --   end,
  --   dependencies = "neovim/nvim-lspconfig"
  -- },

  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = ";", -- Recommended to be a single key
    },
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    -- lazy = false,
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  { "ellisonleao/glow.nvim",     config = true,  cmd = "Glow" },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = overrides.noice,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  {
    "kylechui/nvim-surround",
    -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- {
  --   "Zeioth/compiler.nvim",
  --   cmd = { "CompilerOpen", "CompilerToggleResults" },
  --   dependencies = { "stevearc/overseer.nvim" },
  --   config = function(_, opts)
  --     require("compiler").setup(opts)
  --   end,
  -- },
  --
  -- {
  --   "stevearc/overseer.nvim",
  --   commit = "3047ede61cc1308069ad1184c0d447ebee92d749",
  --   cmd = { "CompilerOpen", "CompilerToggleResults" },
  --   opts = {
  --     -- Tasks are disposed 5 minutes after running to free resources.
  --     -- If you need to close a task inmediatelly:
  --     -- press ENTER in the menu you see after compiling on the task you want to close.
  --     task_list = {
  --       direction = "bottom",
  --       min_height = 25,
  --       max_height = 25,
  --       default_detail = 1,
  --       bindings = {
  --         ["q"] = function()
  --           vim.cmd "OverseerClose"
  --         end,
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "lvimuser/lsp-inlayhints.nvim",
  --   branch = "anticonceal",
  --   event = "LspAttach",
  --   config = function()
  --     require("lsp-inlayhints").setup()
  --   end,
  -- },
  {
    "tpope/vim-repeat",
    lazy = false,
  },

  {
    "LhKipp/nvim-nu",
    ft = { "nu", "nurfile" },
    lazy = false,
    opts = {
      use_lsp_features = true,
    },
    config = function(_, opts)
      require 'nu'.setup(opts)
    end
  },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {
      api_key_cmd = "gpg --decrypt /Users/priyanshu/openapikey.gpg"
    },
    config = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    },
    {
      'kaarmu/typst.vim',
      ft = 'typst',
      lazy = false,
    }
  }
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
