vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2   -- 1 tab = 2 spaces
vim.opt.tabstop = 2      -- Render existing tabs as 2 spaces
vim.opt.softtabstop = 2  -- Fine-tune backspace/tab behavior

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
