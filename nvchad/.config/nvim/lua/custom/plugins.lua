local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",

        -- low level
        "go",
        "python",
        "rust",
      },
    },
  },
  -- In order to modify the `lspconfig` configuration:
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "pyright",
        "rust-analyzer",
        "gopls",
        "prettier",
        "stylua",
        "mypy",
        "ruff",
        "black",
      },
    },
    automatic_installation = true,
  },

  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      ft = { "python", "go", "lua" },
      -- config = function()
      --   require "custom.configs.null-ls"
      -- end,
      opts = function()
        return require "custom.configs.null-ls"
      end,
    },
    -- config = function()
    --   require "plugins.configs.lspconfig"
    --   require "custom.configs.lspconfig"
    -- end,
  },
}
return plugins
