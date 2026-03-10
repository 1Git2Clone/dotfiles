---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",

      -- language adapters
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "fredrikaverpil/neotest-golang",
      "alfaix/neotest-gtest",

      -- **Rust adapter via rustaceanvim**
      {
        "mrcjkb/rustaceanvim",
        ft = "rust", -- only load for Rust
      },
    },
    config = function()
      local neotest = require("neotest")

      neotest.setup({
        adapters = {
          require("neotest-python")({}),
          require("neotest-plenary")({}),
          require("neotest-jest")({}),
          require("neotest-vitest")({}),
          require("neotest-golang")({}),
          require("rustaceanvim.neotest")(), -- **Rust LSP adapter**
          require("neotest-vim-test")({
            ignore_filetypes = {
              "python", "vim", "lua", "javascript", "typescript",
              "go", "rust",
            },
          }),
          require("neotest-gtest").setup({}),
        },
      })
      local keymap_opts = { noremap = true, silent = true }

      vim.keymap.set(
        "n",
        "<leader>tn",
        function() neotest.run.run() end,
        vim.tbl_extend("force", keymap_opts, { desc = "Run nearest test" })
      )
      vim.keymap.set(
        "n",
        "<leader>tf",
        function() neotest.run.run(vim.fn.expand("%")) end,
        vim.tbl_extend("force", keymap_opts, { desc = "Run current file tests" })
      )
      vim.keymap.set(
        "n",
        "<leader>ts",
        function() neotest.summary.toggle() end,
        vim.tbl_extend("force", keymap_opts, { desc = "Toggle test summary window" })
      )
      vim.keymap.set(
        "n",
        "<leader>to",
        function() neotest.output_panel.toggle() end,
        vim.tbl_extend("force", keymap_opts, { desc = "Toggle test output panel" })
      )
      vim.keymap.set(
        "n",
        "<leader>tl",
        function() neotest.run.run({ strategy = "dap" }) end,
        vim.tbl_extend("force", keymap_opts, { desc = "Run test under cursor with debugger" })
      )
      vim.keymap.set(
        "n",
        "<leader>ta",
        function() neotest.run.run({ suite = true }) end,
        vim.tbl_extend("force", keymap_opts, { desc = "Run all tests in project" })
      )

      --[[
      -- Auto Test
      --]]
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          neotest.run.run({ suite = true })
        end,
        pattern = {
          "*.rs",
          -- "*.py",
          -- "*.lua",
          -- "*.js",
          -- "*.ts",
          -- "*.go",
          -- "*.vim",
          -- "*.c",
          -- "*.cc",
          -- "*.cpp",
          -- "*.cxx",
          -- "*.h",
          -- "*.hpp",
        },
      })
    end,
  },
}
