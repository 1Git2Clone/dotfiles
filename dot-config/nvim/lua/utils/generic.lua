local M = {}

---@param tbl table
---@return table
M.make_constant = function(tbl)
  return setmetatable({}, {
    __index = tbl,
    __newindex = function()
      error("Attempt to modify a constant table", 2)
    end,
    __pairs = function()
      return pairs(tbl)
    end,
    __ipairs = function()
      return ipairs(tbl)
    end,
  })
end

return M.make_constant(M)
