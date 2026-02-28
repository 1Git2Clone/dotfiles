-- Credits:
-- - https://mb-izzo.github.io/nvim-godot-solution/
-- - https://simondalvai.org/blog/godot-neovim/
-- - https://www.youtube.com/watch?v=cLWgjienc_s
--
-- NOTE:
-- To use `nvim` as an external editor in Godot, supply the following arguments:
-- - `--server ./godothost --remote-send "<C-\><C-N>:n {file}<CR>{line}G{col}|"`

return {
  {
    "habamax/vim-godot",
    event = "BufReadPre *.gd",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.gdscript.setup({
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        modules = {},
        sync_install = false,
        ignore_install = {},
        ensure_installed = {
          "gdscript",
          "godot_resource",
          "gdshader",
          "bash",
          "c",
          "html",
          "lua",
          "markdown",
          "vim",
          "vimdoc",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
