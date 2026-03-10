local colors = require 'utils.colors'

return {
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    styles = {
      functions = { 'bold' },
    },
    opts = {
      color_overrides = {
        all = {
          text     = '#f7c0c8',
          subtext1 = '#e6aab3',
          subtext0 = '#d4939d',
          overlay2 = '#c17c87',
          overlay1 = '#ab6670',
          overlay0 = '#965159',
          surface2 = '#7f3e44',
          surface1 = '#6a2f36',
          surface0 = '#541f27',
          base     = colors.catppuccin.base,
          mantle   = colors.catppuccin.mantle,
          crust    = colors.catppuccin.crust,
        },
      },
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      dim_inactive = { enabled = false },
      highlight_overrides = {
        all = function()
          local highlights = {
            -- Main UI
            Normal = colors.default_fg_bg,
            NormalNC = colors.default_fg_bg,
            LineNr = { fg = colors.line_col },
            CursorLineNr = { fg = colors.line_hl_col },
            Comment = { fg = colors.comment_col },
            Pmenu = { fg = colors.line_col, bg = colors.default_bg },
            FloatNormal = { bg = colors.default_bg },

            -- Sidebar (NvimTree / NeoTree)
            NvimTreeNormal = { bg = colors.default_bg },
            NvimTreeNormalNC = { bg = colors.default_bg },
            NvimTreeWinSeparator = { fg = colors.default_bg, bg = colors.default_bg },

            -- Telescope
            TelescopeNormal = { bg = colors.default_bg },
            TelescopeBorder = colors.default_fg_bg,
            TelescopePromptNormal = { bg = colors.default_bg },
            TelescopePromptBorder = colors.default_fg_bg,
            TelescopeResultsNormal = { bg = colors.default_bg },
            TelescopeResultsBorder = colors.default_fg_bg,
            TelescopePreviewNormal = { bg = colors.default_bg },
            TelescopePreviewBorder = colors.default_fg_bg,
            TelescopeMatching = { fg = colors.hl_col, bold = true },

            -- WhichKey
            WhichKeyFloat = { bg = colors.default_bg },
            WhichKeyNormal = { bg = colors.default_bg },
            WhichKeyBorder = colors.default_fg_bg,

            -- Snacks & Terminal
            SnacksNormal = { bg = colors.default_bg },
            SnacksNormalNC = { bg = colors.default_bg },
            TerminalNormal = { bg = colors.default_bg },
            SnacksTerminalBorder = colors.default_fg_bg,

            -- LSP / Treesitter
            ['@lsp.type.namespace'] = { fg = colors.module_col },
            ['@lsp.type.enumMember'] = { fg = colors.enum_member_col },

            -- NvimTree
            NvimTreeRootFolder = { fg = colors.default_fg },
            NvimTreeFolderName = { fg = colors.default_fg },
            NvimTreeEmptyFolderName = { fg = colors.default_fg },
            NvimTreeOpenedFolderName = { fg = colors.default_fg },
            NvimTreeFolderIcon = { fg = colors.default_fg },
            NvimTreeHighlights = { fg = colors.default_fg },
          }
          local fg_only_groups = {
            "Directory", "MoreMsg", "Question", "Title", "Folded", "Function",
            "Conditional", "Statement", "Repeat", "Keyword", "Exception", "Include", "Macro" }
          for _, group in ipairs(fg_only_groups) do
            highlights[group] = { fg = colors.default_fg }
          end

          for _, group in ipairs(vim.fn.getcompletion('', 'highlight')) do
            if group:match("^Neogit") or
                group:match("^NvimTree") or
                group:match("^NeoTree") or
                group:match("^DapUI") or
                group:match("^NotifyINFO") or
                group:match("^Neotest") or
                group:match("^RainbowDelimiter") then
              highlights[group] = { fg = colors.default_fg }
            end
          end

          return highlights
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
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        indent_blankline = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = { errors = { 'undercurl' }, hints = { 'undercurl' }, warnings = { 'undercurl' } },
        },
        navic = { enabled = true, custom_bg = 'lualine' },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
