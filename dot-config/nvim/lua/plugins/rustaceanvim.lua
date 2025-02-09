-- Specify desired features enabled based on the current crate (as a folder name).
--
-- NOTE: Unfortunately this isn't hot-reloading, meaning that you'd have to
-- restart neovim each time you change around these features.

require("rustaceanvim")

---@type string
local spec_name = "mrcjkb/rustaceanvim"

---@type { [string]: string[] }
local crate_features = {
  ["taboc"] = {
    "git",
    "memmap2",
  },
}

---@return string[]
local function get_rust_features_based_on_current_crate()
  local cwd = vim.fn.getcwd()
  local crate_name = vim.fn.fnamemodify(cwd, ":t")

  return (crate_features[crate_name] or {})
end

--- @return LazyPlugin
return {
  spec_name,
  ---@type string
  event = "LazyFile",
  ---@return rustaceanvim.Opts
  opt = function()
    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
      ---@type rustaceanvim.tools.Opts
      tools = {},
      ---@type rustaceanvim.lsp.ClientOpts
      server = {
        ---@type boolean
        load_vscode_settings = false,
        ---@type { [string]: table }
        settings = {
          ["rust-analyzer"] = {
            ---@type table
            cargo = {
              ---@type string[]
              features = get_rust_features_based_on_current_crate(),
            },
          },
        },
      },
      ---@type rustaceanvim.dap.Opts
      dap = {},
    }

    return vim.g.rustaceanvim
  end,
}
