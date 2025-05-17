vim.keymap.set({ "i", "s" }, "<Tab>", function()
  local luasnip = require("luasnip")
  if luasnip.expand_or_jumpable() then
    return "<Plug>luasnip-expand-or-jump"
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  local luasnip = require("luasnip")
  if luasnip.jumpable(-1) then
    return "<Plug>luasnip-jump-prev"
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true })
