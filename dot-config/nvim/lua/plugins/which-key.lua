return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    layout = {
      width = { min = 20, max = 50 },
      spacing = 3,
    },
    spec = {
      { '<leader>s', group = '[S]earch',    mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk',  mode = { 'n', 'v' } },
      { 'gr',        group = 'LSP Actions', mode = { 'n' } },
    },
  },
}
