-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

package.path = package.path .. ";~/dotfiles/dot-config/nvim/lua/?.lua"
require("snippets")
require("snippets.classes")

vim.cmd("ShowkeysToggle")

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = "● ",
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
})
