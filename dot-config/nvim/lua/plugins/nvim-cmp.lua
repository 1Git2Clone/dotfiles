return {
  { "hrsh7th/cmp-path" },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      table.insert(opts.sources, { name = "path" })

      opts.formatting = opts.formatting or {}
      local format_original = opts.formatting.format

      opts.formatting.format = function(entry, vim_item)
        if format_original then
          vim_item = format_original(entry, vim_item)
        end

        if entry.source.name == "path" then
          vim_item.kind = "󰉋"
          vim_item.menu = "[Path]"
        end
        return vim_item
      end
    end,
  },
}
