--[[
-- NOTE: Install `tree-sitter-cli` with `cargo install` for the latest version for this config to work.
--]]

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- 1. Setup the install directory (optional, but in the doc you sent)
    ts.setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',
    }

    -- 2. Manually install your languages
    -- This replaces the old 'ensure_installed' table
    ts.install {
      -- Neovim Essentials
      'lua',
      'vim',
      'vimdoc',
      'query',
      'bash',
      'markdown',
      'markdown_inline',
      -- Compiled / Systems
      'c',
      'cpp',
      'rust',
      'go',
      'haskell',
      -- Web Dev
      'javascript',
      'typescript',
      'tsx',
      'vue',
      'svelte',
      'astro',
      'css',
      'html',
      -- Scripting / Config
      'python',
      'php',
      'json',
      'yaml',
      'toml',
      'ron',
      -- Document / CLI
      'latex',
      'bibtex',
      'regex',
    }

    -- 3. THE "MAGIC" FIX: Enable Highlighting
    -- In the rewrite, Tree-sitter does NOT start automatically.
    -- You have to tell Neovim to start it for every file.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- This is the new way to turn on the colors
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
