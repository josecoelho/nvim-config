return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    config = function()
      require "configs.mcphub"
    end,
  },
  -- Avante plugin configuration
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    config = function()
      require("configs.avante").setup()
    end,
    opts = function()
      return require("configs.avante").options
    end,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
      code = { enabled = true },
    },
    ft = { "markdown", "Avante" },
  },

  -- Auto-fix code on save
  {
    "stevearc/conform.nvim",
    event = "BufWritePost", -- Trigger on buffer write
    config = function()
      require "configs.conform" -- Load the configuration for auto-fixing
    end,
  },

  -- Autocompletion plugin
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require("configs.cmp").opts() -- Load options for nvim-cmp
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults() -- Set default LSP configurations
      require "configs.lspconfig" -- Load additional LSP configurations
    end,
  },

  -- Auto-install LSP dependencies
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Language servers and formatters for various languages
        "lua-language-server",
        "stylua",
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",
        "terraform-ls",
        "clangd",
        "clang-format",
        "pyright",
        "ruff",
        "mypy",
        "ts_ls",
      },
    },
  },

  -- Alternative to GitHub Copilot
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    config = function()
      require("supermaven-nvim").setup {} -- Setup the supermaven plugin
    end,
  },

  -- Tab management plugin
  {
    "nanozuki/tabby.nvim",
    event = "VimEnter", -- Load on Vim enter
    dependencies = "nvim-tree/nvim-web-devicons", -- Requires web devicons
    config = function()
      require "configs.tabby" -- Load configuration for tabby
    end,
  },

  -- Tmux integration for seamless navigation
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },

  -- Treesitter for advanced syntax highlighting
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

  -- Tmux focus events integration
  {
    "tmux-plugins/vim-tmux-focus-events",
    event = "VeryLazy",
  },

  -- Surrounding characters manipulation
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },

  -- Git wrapper for Neovim
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
      -- Fix issue of missing netrw disabled by telescope.vim
      -- Reimplement :Browser command to open URLs
      vim.api.nvim_create_user_command("Browse", function(opts)
        vim.fn.system { "open", opts.fargs[1] } -- Open the URL in the default browser
      end, { nargs = 1 })
    end,
  },

  -- Git conflict resolution plugin
  {
    "akinsho/git-conflict.nvim",
    version = "*", -- Use the latest version
    config = true, -- Load the default configuration
    event = "VeryLazy",
  },

  -- Ruby on Rails support
  {
    "tpope/vim-rails",
    event = "VeryLazy",
  },

  -- Automatically add 'end' in Ruby
  {
    "tpope/vim-endwise",
    event = "VeryLazy",
  },

  -- Ruby syntax highlighting and formatting
  {
    "vim-ruby/vim-ruby",
    event = "VeryLazy",
  },

  -- Automatically add 'end' in Ruby
  {
    "tpope/vim-endwise",
    event = "VeryLazy",
  },

  -- GitHub integration for browsing
  {
    "tpope/vim-rhubarb",
    event = "VeryLazy",
  },

  -- Bitbucket integration for browsing
  {
    "tommcdo/vim-fubitive",
    event = "VeryLazy",
  },
}
