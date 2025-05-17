local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local dyn = ls.dynamic_node

local function snake_to_pascal(name)
  local pascal = name:gsub("_(%a)", function(c)
    return c:upper()
  end)
  pascal = pascal:gsub("^%l", string.upper)
  return pascal
end

local function getter_setter(args)
  local field = args[1][1] or ""
  local type = args[2][1] or "type"
  local Field = snake_to_pascal(field)

  return ls.snippet_node(nil, {
    text("  " .. type .. " Get" .. Field .. "();"),
    text({ "", "  void Set" .. Field .. "(" .. type .. " value);" }),
  })
end

-- I'm too lazy to write a loop to dynamically create the class getter/setter snippets

ls.add_snippets("cpp", {
  snip("cls", {
    text("class "),
    insert(1, "ClassName"),
    text({ " {", "public:", "" }),
    dyn(4, getter_setter, { 3, 2 }),
    text({ "", "", "" }),
    text({ "private:", "  " }),
    insert(2, "type"),
    text(" "),
    insert(3, "field"),
    text(";"),
    text({ "", "};" }),
  }),
})

ls.add_snippets("cpp", {
  snip("cls2", {
    text("class "),
    insert(1, "ClassName"),
    text({ " {", "public:", "" }),
    dyn(6, getter_setter, { 3, 2 }),
    text({ "", "" }),
    dyn(7, getter_setter, { 5, 4 }),
    text({ "", "", "" }),
    text({ "private:", "  " }),
    insert(2, "type"),
    text(" "),
    insert(3, "field"),
    text(";"),
    text({ "", "  " }),
    insert(4, "type"),
    text(" "),
    insert(5, "field"),
    text(";"),
    text({ "", "};" }),
  }),
})

ls.add_snippets("cpp", {
  snip("cls3", {
    text("class "),
    insert(1, "ClassName"),
    text({ " {", "public:", "" }),
    dyn(8, getter_setter, { 3, 2 }),
    text({ "", "" }),
    dyn(9, getter_setter, { 5, 4 }),
    text({ "", "" }),
    dyn(10, getter_setter, { 7, 6 }),
    text({ "", "", "" }),
    text({ "private:", "  " }),
    insert(2, "type"),
    text(" "),
    insert(3, "field"),
    text(";"),
    text({ "", "  " }),
    insert(4, "type"),
    text(" "),
    insert(5, "field"),
    text(";"),
    text({ "", "  " }),
    insert(6, "type"),
    text(" "),
    insert(7, "field"),
    text(";"),
    text({ "", "};" }),
  }),
})
