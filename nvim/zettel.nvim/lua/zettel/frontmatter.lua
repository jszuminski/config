-- Minimal, targeted YAML frontmatter field filling. Not a general YAML parser:
-- it sets scalar keys ("status: x") and simple block lists ("key:\n  - a") in
-- the leading `---` block, leaving everything else untouched. This lets us fill
-- prompted values into an existing template without adding placeholder tokens.
local M = {}

---@return integer|nil, integer|nil  inclusive content range of the frontmatter block
local function fm_bounds(lines)
  if lines[1] ~= "---" then
    return nil
  end
  for i = 2, #lines do
    if lines[i] == "---" then
      return 2, i - 1
    end
  end
  return nil
end

---Set a scalar key ("key: value") within [s, e].
local function set_scalar(lines, s, e, key, value)
  local pat = "^(%s*)" .. vim.pesc(key) .. ":"
  for i = s, e do
    local indent = lines[i]:match(pat)
    if indent then
      lines[i] = indent .. key .. ": " .. value
      return true
    end
  end
  return false
end

---Set a block-list key ("key:\n  - a\n  - b") within [s, e], replacing any
---existing (often empty) items.
local function set_list(lines, s, e, key, items)
  local key_idx, key_indent
  for i = s, e do
    local indent = lines[i]:match("^(%s*)" .. vim.pesc(key) .. ":")
    if indent then
      key_idx, key_indent = i, indent
      break
    end
  end
  if not key_idx then
    return false
  end

  -- Existing list items immediately following the key line.
  local last_item = key_idx
  for i = key_idx + 1, e do
    if lines[i]:match("^%s*%-%s") or lines[i]:match("^%s*%-%s*$") then
      last_item = i
    else
      break
    end
  end

  local item_indent = key_indent .. "  "
  if last_item > key_idx then
    item_indent = lines[key_idx + 1]:match("^(%s*)%-") or item_indent
  end

  lines[key_idx] = key_indent .. key .. ":"
  for _ = 1, last_item - key_idx do
    table.remove(lines, key_idx + 1)
  end
  for n = #items, 1, -1 do
    table.insert(lines, key_idx + 1, item_indent .. "- " .. items[n])
  end
  return true
end

---Fill frontmatter fields from a values map. Table values become block lists,
---scalars become "key: value". Missing keys are left as-is.
---@param content string
---@param values table<string, string|string[]>
---@return string
function M.fill(content, values)
  if not values or vim.tbl_isempty(values) then
    return content
  end
  local lines = vim.split(content, "\n")
  if not fm_bounds(lines) then
    return content -- no frontmatter; nothing to fill
  end

  for key, val in pairs(values) do
    local s, e = fm_bounds(lines) -- recompute: list edits change line count
    if s then
      if type(val) == "table" then
        if #val > 0 then
          set_list(lines, s, e, key, val)
        end
      else
        set_scalar(lines, s, e, key, tostring(val))
      end
    end
  end

  return table.concat(lines, "\n")
end

return M
