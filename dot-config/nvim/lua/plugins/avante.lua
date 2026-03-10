---@module 'lazy'
---@type LazySpec
return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'Kaiser-Yang/blink-cmp-avante',
      dependencies = { 'saghen/blink.cmp' },
    },
  },
  build = 'make',
  opts = {
    provider = 'deepseek',
    providers = {
      deepseek = {
        __inherited_from = 'openai',
        api_key_name = 'DEEPSEEK_API_KEY',
        endpoint = 'https://api.deepseek.com/v1',
        model = 'deepseek-chat',
      },
    },
  },
}
