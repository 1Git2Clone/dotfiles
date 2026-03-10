---@module 'lazy'
---@type LazySpec
return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' }, -- Sort imports, then format
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        -- Added CSS/HTML since you have Prettier anyway
        css = { 'prettier' },
        html = { 'prettier' },
        hs = { 'ormolu' },
        rs = { 'rustfmt' },
        go = { 'gofmt' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        -- Grouping JS/TS
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        svelte = { 'prettier' },
        astro = { 'prettier' },
        php = { 'php-cs-fixer' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        tex = { 'latexindent' },
        -- Added TOML (Common in Rust/Python)
        toml = { 'taplo' },
      },
      format_on_save = {
        timeout_ms = 1000, -- Increased timeout for heavier formatters
        lsp_fallback = true,
        quiet = true,
      },
    },
  },
}
