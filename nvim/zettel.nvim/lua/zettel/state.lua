-- Small persisted key/value store, namespaced per vault. Used for the
-- "currently reading" / "current topic" pointers. Stored as JSON under the
-- Neovim data dir so it survives restarts and is independent of the vault.
local config = require("zettel.config")

local M = {}

local function state_path()
  return vim.fs.joinpath(vim.fn.stdpath("data"), "zettel-nvim", "state.json")
end

local function read_all()
  local path = state_path()
  if vim.fn.filereadable(path) == 0 then
    return {}
  end
  local ok, decoded = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
  end)
  return (ok and type(decoded) == "table") and decoded or {}
end

local function write_all(tbl)
  local path = state_path()
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.writefile(vim.split(vim.json.encode(tbl), "\n"), path)
end

local function vault_key()
  local v = config.options.vault
  return (v and v ~= "") and v or "_"
end

---@param key string
---@return table|nil  -- e.g. { name = "2118. ...", path = "/abs/..." }
function M.get(key)
  local entry = read_all()[vault_key()]
  return entry and entry[key] or nil
end

---@param key string
---@param value table|nil
function M.set(key, value)
  local all = read_all()
  local vk = vault_key()
  all[vk] = all[vk] or {}
  all[vk][key] = value
  write_all(all)
end

return M
