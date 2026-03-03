return {
  "mrcjkb/rustaceanvim",
  event = "LazyFile",
  opt = function()
    vim.g.rustaceanvim = {
      server = {
        cmd = function()
          local mason_registry = require("mason-registry")
          if mason_registry.is_installed("rust-analyzer") then
            local ra = mason_registry.get_package("rust-analyzer")
            local ra_filename = ra:get_receipt():get().links.bin["rust-analyzer"]
            return { ("%s/%s"):format(ra:get_installed_version(), ra_filename or "rust-analyzer") }
          else
            -- global installation
            return { "rust-analyzer" }
          end
        end,
      },
      dap = {},
    }

    return vim.g.rustaceanvim
  end,
}
