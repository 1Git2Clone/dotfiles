---@module "lazy"
---@type LazySpec[]
return {
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
    config = function(_, opts) require('mason').setup(opts) end,
  },

  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = 'mason-org/mason.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'clangd',
          'rust_analyzer',
          'lua_ls',
          'svelte',
          'astro',
          'phpactor',
          'gopls',
          'bashls',
          'dockerls',
          'yamlls',
          'jsonls',
          'texlab',
        },
      }
    end,
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = 'mason-org/mason.nvim',
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylua',
          'clang-format',
          'rustfmt',
          'gofmt',
          'shfmt',
          'prettier',
          'php-cs-fixer',
          'latexindent',
          'markdownlint',
          'shellcheck',
          'jsonlint',
          'yamllint',
        },
      }
    end,
  },
}
