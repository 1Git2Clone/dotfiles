---@module "lazy"
---@type LazySpec
return {
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = 'LazyGit',
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'Open Lazygit' },
    },
    config = function()
      -- This plugin *doesn’t* have a setup() function.
      -- It just provides the LazyGit command/terminal.
      -- No need to call require("lazygit").setup().
    end,
  },
}
