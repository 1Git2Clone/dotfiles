---@module "lazy"
---@type LazySpec
return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = 'NvimTreeToggle',
    keys = {
      { '<leader>fe', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
    },
    opts = {
      hijack_netrw = true,
      open_on_tab = false,
      sort_by = 'name',
      view = {
        width = 40,
        side = 'right', -- <-- RIGHT SIDE
        preserve_window_proportions = true,
      },
      renderer = {
        highlight_opened_files = 'all',
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false, -- don't close Neovim
        },
      },
    },
    config = function(_, opts) require('nvim-tree').setup(opts) end,
  },
}
