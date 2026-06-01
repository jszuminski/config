---@class ZettelField
---@field key      string    Frontmatter key to fill / field name.
---@field prompt   string    Prompt text shown to the user.
---@field type?    string    "text" (default) or "select".
---@field choices? string[]  Options when `type == "select"`.
---@field default? string    Default value (prefilled for text, fallback for select).
---@field list?    boolean   Treat comma-separated input as a YAML block list.

---@class ZettelTypeConfig
---@field template? string         Template file path, relative to `vault` (or absolute).
---@field folder?   string         Folder (relative to `vault`) for this type. Defaults to the
---                                global `folder`, so several types can share one ID space.
---@field fields?   ZettelField[]  Extra fields to prompt for and fill into the frontmatter.
---@field set_reading_when? { field: string, equals: string } After creating, set this note as
---                                "currently reading" when the given field equals the value.

---@class ZettelConfig
---@field vault?        string                          Absolute path to the vault root (supports `~`).
---@field folder?       string                          Folder (relative to `vault`) that owns the shared ID space.
---@field id_separator? string                          Character that follows the numeric ID, e.g. ".".
---@field id_start?     integer                         First ID when the folder has no numbered notes.
---@field recursive?    boolean                         Scan subfolders when computing the next ID.
---@field open?         string                          Command used to open the new note ("edit", "vsplit", ...).
---@field date_format?  string                          strftime format for date placeholders.
---@field types?         table<string, ZettelTypeConfig> Note types, keyed by name (e.g. "atom").
---@field placeholders?   table<string, string|fun(ctx: table):string> Literal-string placeholders to substitute in templates.
---@field link_format?    fun(name: string):string        How a state pointer renders in templates. Default: quoted wiki link.
---@field reading_folder? string                          Folder (relative to vault) to pick the currently-reading note from.
---@field topic_folder?   string                          Folder (relative to vault) to pick the current-topic note from. Defaults to the whole vault.

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
  -- How `currently_reading` / `current_topic` render. Quoted because they are
  -- typically used inside YAML frontmatter (e.g. `reference_link: - "[[...]]"`).
  link_format = function(name)
    return '"[[' .. name .. ']]"'
  end,
  reading_folder = nil,
  topic_folder = nil,
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
