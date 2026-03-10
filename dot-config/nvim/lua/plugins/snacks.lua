---@module 'lazy'
---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      terminal = {
        enabled = true,
        win = {
          style = "terminal",
        },
      },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      notifier = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      {
        "<leader>tt",
        function() Snacks.terminal.toggle() end,
        desc = "Toggle Terminal"
      },
      {
        "<C-/>",
        function() Snacks.terminal.toggle() end,
        desc = "Toggle Terminal",
        mode = { "n", "t" }
      },

      -- Bonus: Quick scratch buffer for notes
      {
        "<leader>.",
        function() Snacks.scratch() end,
        desc = "Toggle Scratch Buffer"
      },

      -- Bonus: Notifier history (very useful)
      {
        "<leader>un",
        function() Snacks.notifier.show_history() end,
        desc = "Notification History"
      },
    },
  },
}
