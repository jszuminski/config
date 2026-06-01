---@class ZettelTypeConfig
---@field template? string  Template file path, relative to `vault` (or absolute).
---@field folder?   string  Folder (relative to `vault`) for this type. Defaults to the
---                         global `folder`, so several types can share one ID space.

---@class ZettelConfig
---@field vault?        string                          Absolute path to the vault root (supports `~`).
---@field folder?       string                          Folder (relative to `vault`) that owns the shared ID space.
---@field id_separator? string                          Character that follows the numeric ID, e.g. ".".
---@field id_start?     integer                         First ID when the folder has no numbered notes.
---@field recursive?    boolean                         Scan subfolders when computing the next ID.
---@field open?         string                          Command used to open the new note ("edit", "vsplit", ...).
---@field date_format?  string                          strftime format for date placeholders.
---@field types?        table<string, ZettelTypeConfig> Note types, keyed by name (e.g. "atom").
---@field placeholders? table<string, string|fun(ctx: table):string> Literal-string placeholders to substitute in templates.

local M = {}

---@type ZettelConfig
M.defaults = {
  vault = nil,
  folder = "",
  id_separator = ".",
  id_start = 1,
  recursive = true,
  open = "edit",
  date_format = "%Y-%m-%d %H:%M",
  types = {},
  placeholders = {},
}

---Resolved options (populated by `setup`).
---@type ZettelConfig
M.options = {}

---@param opts? ZettelConfig
---@return ZettelConfig
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
  if M.options.vault and M.options.vault ~= "" then
    -- Expand ~ and normalize, drop any trailing slash.
    local expanded = vim.fn.fnamemodify(vim.fn.expand(M.options.vault), ":p")
    M.options.vault = (expanded:gsub("/$", ""))
  end
  return M.options
end

return M
