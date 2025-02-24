return {
  require("plugins.avante")[1],
  {
    -- gpt chat using MD
    "robitx/gp.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.gpnvim"
    end,
  },
  {
    -- auto fix on save
    "stevearc/conform.nvim",
    event = "BufWritePost", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require("configs.cmp").opts()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    -- auto install lsp dependencies
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",

        -- terraform stuff
        "terraform-ls",

        -- c/cpp stuff
        "clangd",
        "clang-format",

        -- python stuff
        "pyright",
        "ruff",
        "mypy",

        -- ts
        "ts_ls",
      },
    },
  },
  {
    -- copilot alternative
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    config = function()
      require("supermaven-nvim").setup {}
    end,
  },
  {
    "nanozuki/tabby.nvim",
    event = "VimEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require "configs.tabby"
    end,
  },

  -- Tmux integration
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "markdown",
        "markdown_inline",
      },
    },
  },
  {
    "tmux-plugins/vim-tmux-focus-events",
    event = "VeryLazy",
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  -- Git wrapper
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
      -- fix issue of missing netrw disabled by telescope.vim
      -- reimplement :Browser command
      vim.api.nvim_create_user_command("Browse", function(opts)
        vim.fn.system { "open", opts.fargs[1] }
      end, { nargs = 1 })
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    event = "VeryLazy",
  },
  {
    "tpope/vim-rails",
    event = "VeryLazy",
  },
  {
    "tpope/vim-endwise",
    event = "VeryLazy",
  },
  {
    "tpope/vim-rhubarb",
    event = "VeryLazy",
  },
  -- :GBrowse bit bucket
  {
    "tommcdo/vim-fubitive",
    event = "VeryLazy",
  },
}
