return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true })
  end,
  opts = function(_, opts)
    opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities or {}, {
      offsetEncoding = { "utf-8" },
      positionEncoding = "utf-8",
    })
  end,
}
