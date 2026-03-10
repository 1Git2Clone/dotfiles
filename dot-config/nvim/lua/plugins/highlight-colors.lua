return {
  -- Inline color highlighting
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },

  -- Fast colorizer (hex/rgb etc)
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Popup color picker
  {
    "ziontee113/color-picker.nvim",
    keys = { { "<C-c>", "<cmd>PickColor<cr>", desc = "Pick Color" } },
    config = true,
  },

  -- Color utils
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
  },

  -- Graphical picker + highlight
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
