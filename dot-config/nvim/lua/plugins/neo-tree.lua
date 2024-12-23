-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/2d4094b885ea642f590997e92ffe6415fdc60185/README.md
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
        window = {
          position = "right",
        },
      })
    end,
  },
}
