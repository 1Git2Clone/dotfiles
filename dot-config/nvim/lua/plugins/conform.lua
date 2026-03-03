return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {

    formatters_by_ft = {

      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },

      lua = { "stylua" },

      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },

      rust = { "rustfmt" },

      python = { "black" },
      py = { "black" },

      go = { "gofumpt", "goimports" },

      haskell = { "fourmolu", "ormolu" },
      hs = { "fourmolu", "ormolu" },
      lhs = { "fourmolu", "ormolu" },
      cabal = { "cabal_fmt" },

      markdown = { "prettierd", "prettier", stop_after_first = true },
      mdx = { "prettierd", "prettier", stop_after_first = true },

      yaml = { "yamlfmt", "prettierd", "prettier", stop_after_first = true },
      yml = { "yamlfmt", "prettierd", "prettier", stop_after_first = true },

      c = { "clang-format" },
      cpp = { "clang-format" },
      h = { "clang-format" },
      hpp = { "clang-format" },

      java = { "google-java-format" },

      ruby = { "rubocop" },
      rb = { "rubocop" },

      php = { "pint", "php-cs-fixer" },

      sql = { "sqlfluff" },

      graphql = { "prettierd", "prettier", stop_after_first = true },
      gql = { "prettierd", "prettier", stop_after_first = true },

      toml = { "taplo" },

      dockerfile = { "dockerfilefmt" },

      ["_"] = { "lsp_format" },
    },

    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      black = {
        prepend_args = { "--line-length", "88" },
      },
      rustfmt = {},
      gofumpt = {},
      goimports = {},
      fourmolu = {
        prepend_args = { "--indentation", "2", "--comma-style", "leading" },
      },
    },

    log_level = vim.log.levels.WARN,
  },
}
