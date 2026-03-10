vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Override <leader>fe inside Neo-tree buffers to close it
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function()
    -- Close Neo-tree with same mapping
    vim.keymap.set('n', '<leader>fe', '<cmd>Neotree close<CR>', { buffer = true, desc = 'Close Neo-tree' })
  end,
})

-- Start Treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

-- Re-add LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: [G]oto [D]efinition', buffer = event.buf })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP: [G]oto [R]eferences', buffer = event.buf })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover Documentation', buffer = event.buf })
  end,
})
