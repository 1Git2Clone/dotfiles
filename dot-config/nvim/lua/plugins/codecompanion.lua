return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = os.getenv("DEEPSEEK_API_KEY"), -- From `~/.profile.d/environment-variables.sh`
            },
            schema = {
              model = {
                default = "deepseek-chat",
              },
              max_tokens = {
                default = 8192,
              },
              temperature = {
                default = 0.7,
              },
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
        cmd = { adapter = "deepseek" },
      },
      opts = {
        log_level = "DEBUG",
      },
    })

    vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>", { desc = "Open CodeCompanion Chat" })
    vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "Open CodeCompanion Inline" })
    vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "Open CodeCompanion Inline (Visual)" })
  end,
}
