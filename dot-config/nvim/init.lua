-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

package.path = package.path .. ";~/dotfiles/dot-config/nvim/lua/?.lua"
require("snippets")
require("snippets.classes")

vim.cmd("ShowkeysToggle")
