-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.api.nvim_set_keymap("n", "<space>", ":colorscheme habamax", { noremap = true, silent = true })

require("config.global_functions")({
	-- Do a shell command and pipe the output to a new buffer
	vim.api.nvim_set_keymap(
		"n",
		"<leader>C",
		":lua RUN_COMMAND_IN_NEW_BUFFER()<CR>",
		{ noremap = true, silent = false }
	),
})
