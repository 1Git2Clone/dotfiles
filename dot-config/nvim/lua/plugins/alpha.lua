local colors = require("utils.colors")

return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set custom highlight groups
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = colors.default_fg })
    vim.api.nvim_set_hl(0, "AlphaButtons", colors.default_fg_bg)
    vim.api.nvim_set_hl(0, "AlphaFooter", { fg = colors.default_fg, italic = true })
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = colors.default_fg, italic = true })

    -- Credit for this dope text:
    -- http://patorjk.com/software/taag/#p=display&f=The%20Edge&t=Hu%20Tao!
    dashboard.section.header.val = {
      "▄   █   ▄          ▄▄▄▄▀ ██   ████▄   ▄",
      "█   █    █      ▀▀▀ █    █ █  █   █  █ ",
      "██▀▀█ █   █         █    █▄▄█ █   █ █  ",
      "█   █ █   █        █     █  █ ▀████ █  ",
      "   █  █▄ ▄█       ▀         █          ",
      "  ▀    ▀▀▀                 █        ▀  ",
      "                          ▀            ",
    }

    alpha.setup(dashboard.opts)

    return opts
  end,
}
