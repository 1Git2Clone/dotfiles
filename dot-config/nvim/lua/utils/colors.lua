local M = {}

---@type string
M.default_fg = "#ff5077"
---@type string
M.default_bg = "#110003"

---@type { fg: string, bg: string }
M.default_fg_bg = { fg = M.default_fg, bg = M.default_bg }

---@type string
M.line_hl_col = "#ff003e"
---@type string
M.line_col = "#da5876"
---@type string
M.comment_col = "#ffb3c3"

return M
