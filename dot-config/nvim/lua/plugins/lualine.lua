local colors = require("utils.colors")

return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local lualine_theme = require("lualine.themes.auto")

    for _, mode in pairs({ "normal", "insert", "visual", "replace", "command", "inactive", "terminal" }) do
      lualine_theme[mode].a = colors.default_fg_bg
      lualine_theme[mode].b = colors.default_fg_bg
      lualine_theme[mode].c = colors.default_fg_bg
    end

    return {
      options = {
        theme = lualine_theme,
      },
    }
  end,
}
