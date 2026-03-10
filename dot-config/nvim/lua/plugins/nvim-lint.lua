---@module "lazy"
---@type LazySpec
return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        lua = { 'luacheck' },
        python = { 'ruff' },
        sh = { 'shellcheck' },
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        json = { 'jsonlint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable and not vim.tbl_contains({ 'alpha', 'TelescopePrompt' }, vim.bo.filetype) then lint.try_lint() end
        end,
      })
    end,
  },
}
