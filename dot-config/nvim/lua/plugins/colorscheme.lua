local default_fg = "#ff5077"
local default_bg = "#110003"
local default_fg_bg = { fg = default_fg, bg = default_bg }

return {
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000,
    styles = {
      functions = { "bold" },
    },
    -- credit to the original color overrides:
    --https://github.com/b-ggs/dotfiles/blob/becba14045586db9ee2becf39fbe07f0f8ae0a68/nvim/.config/nvim/init.vim#L203-L237
    opts = {
      color_overrides = {
        all = {
          text = "#f4cdd5",
          subtext1 = "#debac2",
          subtext0 = "#c9a6ae",
          overlay2 = "#b39497",
          overlay1 = "#9b7d82",
          overlay0 = "#856a6d",
          surface2 = "#6f585d",
          surface1 = "#594548",
          surface0 = "#443131",

          base = "#110003",
          mantle = "#100001",
          crust = "#100001",
        },
      },
      highlight_overrides = {
        all = function()
          return {
            DashboardHeader = { fg = "#ff416e" },
            DashboardIcon = { fg = "#ff668a" },
            DashboardDesc = { fg = "#bb8992" },
            DashboardKey = { fg = "#ff668a" },
            DashboardFooter = { fg = "#ff517a" },
            -- Thank god it was as easy as getting chat gippidy to make
            -- a python script for this all
            Directory = { fg = default_fg },
            MoreMsg = { fg = default_fg },
            Question = { fg = default_fg },
            Title = { fg = default_fg },
            Folded = { fg = default_fg },
            FloatBorder = { fg = default_fg },
            Function = { fg = default_fg },
            diffChanged = { fg = default_fg },
            markdownLinkText = { fg = default_fg },
            NavicIconsTypeParameter = { fg = default_fg },
            NavicIconsEvent = { fg = default_fg },
            NavicIconsStruct = { fg = default_fg },
            NavicIconsFunction = { fg = default_fg },
            NavicIconsMethod = { fg = default_fg },
            NavicIconsPackage = { fg = default_fg },
            NavicIconsModule = { fg = default_fg },
            NeogitTagDistance = { fg = default_fg },
            NeogitDiffHeader = { fg = default_fg },
            NeogitGraphBoldBlue = { fg = default_fg },
            NeogitGraphBlue = { fg = default_fg },
            NeogitGraphCyan = { fg = default_fg },
            NeoTreeRootName = { fg = default_fg },
            NeogitChangeModified = { fg = default_fg },
            NoiceConfirmBorder = { fg = default_fg },
            NeotestWinSelect = { fg = default_fg },
            NeotestDir = { fg = default_fg },
            NeotestFile = { fg = default_fg },
            NvimTreeGitNew = { fg = default_fg },
            NvimTreeEmptyFolderName = { fg = default_fg },
            NvimTreeOpenedFolderName = { fg = default_fg },
            NvimTreeFolderIcon = { fg = default_fg },
            NvimTreeFolderName = { fg = default_fg },
            MiniStatuslineInactive = { fg = default_fg },
            MiniStarterItemBullet = { fg = default_fg },
            MiniStarterHeader = { fg = default_fg },
            qfFileName = { fg = default_fg },
            htmlH2 = { fg = default_fg },
            diffFile = { fg = default_fg },
            GlyphPalette4 = { fg = default_fg },
            TelescopeMatching = { fg = default_fg },
            NavicIconsConstructor = { fg = default_fg },
            NeogitFilePath = { fg = default_fg },
            NeoTreeDirectoryIcon = { fg = default_fg },
            NeoTreeDirectoryName = { fg = default_fg },
            WhichKeyGroup = { fg = default_fg },
            NeogitNotificationInfo = { fg = default_fg },
            NeogitHunkHeaderHighlight = { fg = default_fg },
            NotifyINFOTitle = { fg = default_fg },
            NotifyINFOIcon = { fg = default_fg },
            NotifyINFOBorder = { fg = default_fg },
            NeogitGraphBoldCyan = { fg = default_fg },
            CmpItemKindTypeParameter = { fg = default_fg },
            CmpItemKindOperator = { fg = default_fg },
            CmpItemKindEvent = { fg = default_fg },
            CmpItemKindStruct = { fg = default_fg },
            CmpItemKindFile = { fg = default_fg },
            CmpItemKindModule = { fg = default_fg },
            CmpItemKindFolder = { fg = default_fg },
            CmpItemKindFunction = { fg = default_fg },
            CmpItemKindConstructor = { fg = default_fg },
            CmpItemKindMethod = { fg = default_fg },
            CmpItemKind = { fg = default_fg },
            RainbowDelimiterBlue = { fg = default_fg },
            NeotestSkipped = { fg = default_fg },
            AlphaHeader = { fg = default_fg },
            NavicIconsFile = { fg = default_fg },
            NavicIconsNamespace = { fg = default_fg },
            DapUIStepOver = { fg = default_fg },
            DapUIStepInto = { fg = default_fg },
            DapUIStepBack = { fg = default_fg },
            DapUIStepOut = { fg = default_fg },
            lualine_a_inactive = { fg = default_fg },
            lualine_b_normal = { fg = default_fg },
            NoiceAttr90 = { fg = default_fg },
            NoiceAttr103 = { fg = default_fg },
            NoiceAttr120 = { fg = default_fg },
            NoiceAttr130 = { fg = default_fg },
            NoiceAttr143 = { fg = default_fg },
            NoiceAttr194 = { fg = default_fg },
            NoiceAttr214 = { fg = default_fg },
            NoiceAttr221 = { fg = default_fg },
            NoiceAttr283 = { fg = default_fg },
            lualine_transitional_lualine_a_normal_to_lualine_c_filetype_DevIconDefault_normal = {
              fg = default_fg,
            },
            lualine_transitional_lualine_a_normal_to_lualine_b_normal = { fg = default_fg },
            Conditional = { fg = default_fg },
            Statement = { fg = default_fg },
            Repeat = { fg = default_fg },
            Keyword = { fg = default_fg },
            Exception = { fg = default_fg },
            Include = { fg = default_fg },
            Macro = { fg = default_fg },
            NeogitUntrackedfiles = { fg = default_fg },
            NeogitRebasing = { fg = default_fg },
            NeogitStashes = { fg = default_fg },
            NeogitStagedchanges = { fg = default_fg },
            NeogitRecentcommits = { fg = default_fg },
            NeogitUnpulledchanges = { fg = default_fg },
            NeogitUnmergedchanges = { fg = default_fg },
            NeogitUnstagedchanges = { fg = default_fg },
            NeoTreeGitUntracked = { fg = default_fg },
            CmpItemKindSnippet = { fg = default_fg },
            NeogitChangeRenamed = { fg = default_fg },
            NeogitSectionHeader = { fg = default_fg },
            DapUIType = { fg = default_fg },
            MasonHighlightSecondary = { fg = default_fg },
            NeotestNamespace = { fg = default_fg },
            DapBreakpointRejected = { fg = default_fg },
            RainbowDelimiterViolet = { fg = default_fg },
            -- Operator = { fg="FF5050" }
            Normal = { fg = "#fb89a4", bg = "#110003" },
            LineNr = { fg = "#da5876" },
            Pmenu = { fg = "#da5876" },
            CursorLineNr = { fg = "#ff003e" },
            Comment = { fg = "#ffb3c3" },
          }
        end,
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local lualine_theme = require("lualine.themes.auto")

      for _, mode in pairs({ "normal", "insert", "visual", "replace", "command", "inactive", "terminal" }) do
        lualine_theme[mode].a = default_fg_bg
        lualine_theme[mode].b = default_fg_bg
        lualine_theme[mode].c = default_fg_bg
      end

      return {
        options = {
          theme = lualine_theme,
        },
      }
    end,
  },
  -- alpha-nvim
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set custom highlight groups
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = default_fg })
      vim.api.nvim_set_hl(0, "AlphaButtons", default_fg_bg)
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = default_fg, italic = true })
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = default_fg, italic = true })

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
  },
}
