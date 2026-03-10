vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Change focused windows easier
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

vim.keymap.set('n', '<leader>fe', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Explorer' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })

-- change indentation and keep selection
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
