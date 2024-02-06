local Util = require("lazyvim.util")

return {
	-- Better `vim.notify()`
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},

	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	-- This is what powers LazyVim's fancy-looking
	-- tabs, which include filetype icons and close buttons.
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		},
		opts = {
			options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("lazyvim.config").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd("BufAdd", {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			-- PERF: we don't need this lualine require madness 🤷
			local lualine_require = require("lualine_require")
			lualine_require.require = require

			local icons = require("lazyvim.config").icons

			vim.o.laststatus = vim.g.lualine_laststatus

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },

					lualine_c = {
						Util.lualine.root_dir(),
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ Util.lualine.pretty_path() },
					},
					lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.ui.fg("Debug"),
            },
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = Util.ui.fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "LazyFile",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},

	-- Active indent guide and indent text objects. When you're browsing
	-- code, this highlights the current level of indentation, and animates
	-- the highlighting.
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "LazyFile",
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- Displays a popup with possible key bindings of the command you started typing
	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			if require("lazyvim.util").has("noice.nvim") then
				opts.defaults["<leader>sn"] = { name = "+noice" }
			end
		end,
	},

	-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
			},
		},
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
	},

	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },

	{
		"goolord/alpha-nvim",
		optional = true,
		enabled = function()
			require("lazyvim.util").warn({
				"`dashboard.nvim` is now the default LazyVim starter plugin.",
				"",
				"To keep using `alpha.nvim`, please enable the `lazyvim.plugins.extras.ui.alpha` extra.",
				"Or to hide this message, remove the alpha spec from your config.",
			})
			return false
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function()
			-- local logo = [[
			--         ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
			--         ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
			--         ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
			--         ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
			--         ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
			--         ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
			--    ]]
			-- local logo = [[
			--                                                #
			--                                    ####       #+
			--                            ####++++++++++###++#
			--                        ##-+#++++++++++++++++###
			--                #######++++++++++++++++++++++++++#
			--                  ##-++++++++++++++++++++++++++++++#
			--                  ##-++++++++++++++++++++++++++++++++##
			--                ##--++-++++++++++++++++++++++++++++++##
			--                #--++--++++++++++++. -++++++++++++++++##
			--                #+-++++++++##++++++-  .#+++++++++++++#++#
			--                #-+++++++++##++++++   .-#++++++++++++#++#
			--                #-+++++++  ##+++++#      +++++#++++++#++#
			--              #--++++#    .+++++++  .-+-..#++#++++++#++#
			--              #+-+++.#####.+-.++++.-+########++++++#++##
			--              #+++++# ##.-#-+ .+++- ++  -#--++++++#+++#
			--              #++++-...+.++-    .++ .--+++-.++++#+++++#
			--              #+++++    +++        ..-+++  #-##++++##++#
			--              ##+#+++   .-.--   .-....-.     ++++++###+#
			--                #+#++-+-.. .  ....       +   #+++++++#  ##
			--                ###+++.-.....             -  +++#+++++##
			--              ## #++++-.-+###    .++++   +-+#++#+++++++##
			--                  #+++++...   -+++-       ####++#+++++++++#
			--                #++++++++  .- +++++   .. .-+####+#+++++++++
			--              ##++++++#     - .+.         +#####+#++++++++
			--    ]]
			-- local logo = [[
			--                ⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠈⢧⠹⡀⠀⠀⠸⡇⠀⠀⢸⠃⠀⠉⢳⡘⢭⠇⠀⣠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			--                ⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠘⣆⢳⣀⣀⣀⣇⣀⣀⣼⣀⡀⠀⠈⣧⠾⣷⡋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			--                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⠀⠀⢀⣀⣤⡴⣖⣲⣋⣯⣭⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			--                ⠀⠀⠀⠀⠀⠀⠀⠀⢠⣏⣤⠴⢚⣫⣥⣶⣾⣿⣿⡿⡿⠛⠛⠛⠛⠛⠛⢛⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			--                ⠀⠀⠀⠀⠀⠀⢀⣴⢟⣩⣴⣾⡿⠿⠛⠉⠉⢸⠋⢆⢻⠀⠀⠀⠀⠀⢀⠘⡆⠀⠀⠀⠈⠉⠙⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀
			--                ⢀⣀⣠⣤⠀⣟⣿⣾⣿⠟⠋⢩⠀⠀⠀⠀⢀⣏⡠⠼⣿⣧⠀⠀⠐⠀⠘⡄⢳⠖⠲⢤⣀⠀⠀⠈⢻⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀
			--                ⣉⠝⢋⣽⣦⣿⡟⠉⠀⠀⠀⡞⠀⠀⠀⣴⡿⠁⠀⠀⠘⢿⣆⠀⠀⠀⠀⣇⠘⣷⡀⠀⠉⠁⠀⢦⠀⠹⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀
			--                ⣡⣾⡿⠛⢹⣿⠃⠀⠀⢀⢰⡇⠀⠀⠀⡼⠁⠀⠀⠀⠀⠈⢿⡄⠀⠀⠀⢸⡄⢻⠙⣄⠀⠀⠀⠈⢇⠀⠹⣿⣿⣿⣿⣏⠳⡄⠀⠀⠀⠀
			--                ⣿⡏⠀⠀⣸⢸⠀⠀⠀⠈⢨⡇⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠈⢿⡄⠀⠀⠀⡿⡬⡇⠈⢳⡀⠀⠀⢸⡄⠀⢹⣿⣿⣿⣿⢿⠃⠀⠀⠀⠀
			--                ⣿⡇⠀⠀⢸⢸⠀⠀⠀⠀⢸⠃⣠⠞⠀⠀⠀⣀⣠⣤⡤⣄⣀⠀⠻⣆⠀⠀⣇⢘⣿⣤⣄⣹⣤⠀⠀⣧⠀⠀⢿⣿⣯⣼⣿⠀⠀⠀⠀⠀
			--                ⠹⡇⠀⠀⢸⡄⠀⠀⠀⠀⢸⣟⠁⠀⣶⣴⣾⣿⣿⣿⣿⣶⣤⡀⠀⠈⢧⠀⢸⣀⣼⣿⣿⣏⠻⣧⣀⢹⡆⠀⢸⡟⠀⠀⢿⣦⠀⠀⠀⠀
			--                ⠀⣿⠀⠀⠈⣷⡆⠀⠀⠀⣸⣤⣿⠟⠋⠀⣿⣿⠋⢻⡿⢷⠀⠀⠀⠀⠀⠳⣈⣇⢸⡇⢸⣿⡄⣿⣧⣸⣿⡄⠈⡇⠀⠀⣼⣿⣆⠀⠀⠀
			--                ⠀⢸⡇⠀⢀⠀⢧⠀⠀⠀⠹⡟⠳⠀⠀⠀⢻⣿⠴⠾⠣⣿⠀⠀⠀⠀⠀⠀⠙⢿⡌⢿⣶⡿⢁⡘⣿⣿⣿⣷⠀⡇⠀⠀⣿⣿⣿⡆⠀⠀
			--                ⠀⠀⣿⡇⠐⠀⠘⣆⠀⠀⠀⢳⡀⠀⣄⡀⠀⠙⠒⡖⠚⠃⠀⠀⠀⠀⠀⠀⠀⠀⠙⠤⠬⠄⠘⠃⠹⣿⣿⣿⣿⠇⠀⢀⣿⣿⣿⣿⡀⠀
			--                ⠀⢰⣯⢷⡀⠀⠀⠹⣄⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠃⠀⠀⠀⠀⠀⢻⣿⣿⡟⠀⠀⢸⣿⣿⣿⣿⡇⠀
			--                ⠀⣾⠁⠀⢳⡀⠀⠀⢻⣦⠀⠰⡶⠤⢽⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠙⡇⠀⠀⠈⣿⣿⣿⣿⡗⠀
			--                ⢀⡇⣄⠀⠀⣽⣄⠀⠈⣿⣿⢦⣱⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡏⢀⡿⡄⠀⠀⠘⠛⠛⠋⠀⠀
			--                ⣸⣿⣮⣝⠒⡇⡾⠳⣄⠸⣿⠀⠈⠉⠀⠀⢀⣤⣤⣄⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⡇⣸⠁⠘⣆⠀⠀⠀⠀⠀⠀⠀
			--                ⣿⣿⠙⠿⢿⡇⡇⠀⠀⡿⢻⣧⡀⠀⣴⣶⣦⡉⢿⡁⠙⠢⡀⠘⣿⠟⢆⠀⠀⠀⠀⠀⠀⠀⢀⡴⠙⣿⠟⠁⠀⠀⠈⢣⡀⠀⠀⠀⠀⠀
			--                ⣿⡿⠀⠀⢸⣿⡇⠀⠀⢹⠀⣿⣿⡆⢿⣿⡁⠙⢦⡙⢆⠀⠈⠢⡘⡄⠈⢢⠀⠀⠀⠀⠀⣠⠊⠀⠀⠸⡄⠀⠀⠀⠀⠀⠳⡄⠀⠀⠀⠀
			--                ⣿⡇⠀⠀⢸⢠⡇⠀⠀⢸⠀⣻⠹⡇⠘⡇⠑⣄⠀⠉⠢⣵⡄⠀⠘⢿⡄⠀⢣⠀⠀⣠⠞⠁⠀⠀⠀⠀⢹⡀⠀⠀⠀⠀⠀⠹⡄⠀⠀⠀
			--                ⣿⠃⠀⠀⢸⢸⠀⠀⠀⠘⡇⢹⠀⡇⠀⠘⣤⣬⡳⣖⠲⡿⠻⡄⠀⠀⢣⠀⠈⣷⣾⣿⡇⠀⠀⠀⠀⠀⠀⢣⠀⠀⠰⡄⠀⠀⠹⡄⠀⠀
			--                ⣿⠀⠀⠀⢸⢸⠀⠀⠀⠀⣇⠸⡟⠋⠓⠒⠻⣄⢹⠛⢶⠃⠐⠛⠀⠀⠀⠀⠀⠘⣿⣿⣇⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⢳⡀⠀⠀⠹⡀⠀
			--                ⡇⠀⠀⠀⢸⢸⠀⠀⠀⠀⢹⠀⡇⠀⠀⠀⠀⠘⣿⣄⠈⠂⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⠈⣧⠀⠀⠀⢱⠀
			--                ⠃⠀⠀⠀⠸⣿⡆⠀⠀⠀⠘⡇⢹⣤⣀⡀⠀⠀⢹⡜⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣇⠀⠀⠀⠀⠀⠀⠀⢹⣆⠀⢹⡆⠀⠀⠀⢧
			--                ⠀⠀⠀⣀⣴⣿⡇⠀⣇⠀⠀⠀⠘⣿⣿⣿⣿⣶⣤⣷⣄⡱⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣄⡀⠀⠀⠀⠀⠀⠀⢿⡄⠘⣷⠀⠀⠀⠘
			--                ██╗  ██╗██╗   ██╗    ████████╗ █████╗  ██████╗ ██╗
			--                ██║  ██║██║   ██║    ╚══██╔══╝██╔══██╗██╔═══██╗██║
			--                ███████║██║   ██║       ██║   ███████║██║   ██║██║
			--                ██╔══██║██║   ██║       ██║   ██╔══██║██║   ██║╚═╝
			--                ██║  ██║╚██████╔╝       ██║   ██║  ██║╚██████╔╝██╗
			--                ╚═╝  ╚═╝ ╚═════╝        ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝
			--    ]]
			local logo = [[
                  ██╗  ██╗██╗   ██╗    ████████╗ █████╗  ██████╗ ██╗                 
                  ██║  ██║██║   ██║    ╚══██╔══╝██╔══██╗██╔═══██╗██║                 
                  ███████║██║   ██║       ██║   ███████║██║   ██║██║                 
                  ██╔══██║██║   ██║       ██║   ██╔══██║██║   ██║╚═╝                 
                  ██║  ██║╚██████╔╝       ██║   ██║  ██║╚██████╔╝██╗                 
                  ╚═╝  ╚═╝ ╚═════╝        ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝                 
      ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = {
					-- this is taken care of by lualine
					-- enabling this messes up the actual laststatus setting after loading a file
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
            { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ HuTaovim loaded "
								.. stats.loaded
								.. "/"
								.. stats.count
								.. " plugins in "
								.. ms
								.. "ms",
						}
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "DashboardLoaded",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			return opts
		end,
	},
}
