local M = {}

---@type { base: string, mantle: string, crust: string }
M.catppuccin = {
  base = '#110000',
  mantle = '#110000',
  crust = '#110000',
}

---@type string
M.default_fg = '#ff5077'
---@type string
M.default_bg = '#110000'
---@type string
M.module_col = '#ff9999'
---@type string
M.enum_member_col = '#ffaa88'

---@type { fg: string, bg: string }
M.default_fg_bg = { fg = M.default_fg, bg = M.default_bg }

---@type string
M.line_hl_col = '#ff003e'
---@type string
M.hl_col = '#ffaa88'
---@type string
M.line_col = '#da5876'
---@type string
M.comment_col = '#ffb3c3'

return require('utils.generic').make_constant(M)
