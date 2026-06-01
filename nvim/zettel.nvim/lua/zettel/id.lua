local M = {}

---Parse the leading numeric ID from a filename.
---  "3314. Some title.md" with sep "." -> 3314
---  "README.md"          with sep "." -> nil
---@param name string Filename (basename; extension is fine).
---@param sep  string ID separator.
---@return integer|nil
function M.parse_id(name, sep)
  local prefix = name:match("^(.-)" .. vim.pesc(sep))
  if not prefix then
    return nil
  end
  return tonumber(vim.trim(prefix))
end

---Compute the next ID for a folder by scanning existing notes for the highest
---numeric prefix and adding one. Mirrors the Obsidian plugin's behaviour.
---@param folder string Absolute folder path.
---@param sep    string ID separator.
---@param opts?  { recursive?: boolean, id_start?: integer }
---@return integer
function M.next_id(folder, sep, opts)
  opts = opts or {}
  local depth = opts.recursive == false and 1 or 100
  local max_id = nil

  local ok, iter = pcall(vim.fs.dir, folder, { depth = depth })
  if ok and iter then
    for name, type_ in iter do
      if type_ == "file" and name:sub(-3) == ".md" then
        local id = M.parse_id(vim.fs.basename(name), sep)
        if id and (not max_id or id > max_id) then
          max_id = id
        end
      end
    end
  end

  if not max_id then
    return opts.id_start or 1
  end
  return max_id + 1
end

return M
