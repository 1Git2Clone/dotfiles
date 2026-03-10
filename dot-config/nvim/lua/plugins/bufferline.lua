---@module 'lazy'
---@type LazySpec
return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    config = function()
      local ok, bufferline = pcall(require, 'bufferline')
      if not ok then return end

      bufferline.setup {
        options = {
          numbers = 'none',
          show_buffer_close_icons = true,
          show_close_icon = false,
          separator_style = 'thin',
          always_show_bufferline = true,
          diagnostics = 'nvim_lsp',
          close_command = function(bufnr)
            -- Get list of listed buffers excluding Nvim-tree
            local bufs = vim.fn.getbufinfo { buflisted = 1 }
            local last_buf = nil
            for i = #bufs, 1, -1 do
              if bufs[i].name:match '.*NeoTree.*' == nil and bufs[i].bufnr ~= bufnr then
                last_buf = bufs[i].bufnr
                break
              end
            end

            if last_buf then
              vim.cmd(string.format('buffer %d | bdelete %d', last_buf, bufnr))
            else
              -- No other buffer, just delete
              vim.cmd(string.format('bdelete %d', bufnr))
            end
          end,
          right_mouse_command = function(bufnr)
            local alternate = vim.fn.bufnr '#'
            if vim.api.nvim_buf_is_valid(alternate) then
              vim.cmd(string.format('buffer %d | bdelete %d', alternate, bufnr))
            else
              vim.cmd(string.format('bdelete %d', bufnr))
            end
          end,
        },
      }

      local function safe_cycle_prev()
        local bufs = vim.fn.getbufinfo { buflisted = 1 }
        if #bufs > 1 then vim.cmd 'BufferLineCyclePrev' end
      end

      local function safe_cycle_next()
        local bufs = vim.fn.getbufinfo { buflisted = 1 }
        if #bufs > 1 then vim.cmd 'BufferLineCycleNext' end
      end

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', 'H', safe_cycle_prev, opts)
      vim.keymap.set('n', 'L', safe_cycle_next, opts)
    end,
  },
}
