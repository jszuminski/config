local config = require("zettel.config")
local state = require("zettel.state")

local M = {}

-- moment.js-style tokens -> strftime. Longest tokens first so e.g. "YYYY" is
-- consumed before "YY". The replacement uses "%%" so gsub emits a literal "%".
local MOMENT_TO_STRFTIME = {
  { "YYYY", "%%Y" },
  { "YY", "%%y" },
  { "MM", "%%m" },
  { "DD", "%%d" },
  { "HH", "%%H" },
  { "mm", "%%M" },
  { "ss", "%%S" },
}

---Convert a moment.js-style date format ("YYYY-MM-DD HH:mm") to strftime.
---@param fmt string
---@return string
function M.moment_to_strftime(fmt)
  for _, pair in ipairs(MOMENT_TO_STRFTIME) do
    fmt = fmt:gsub(pair[1], pair[2])
  end
  return fmt
end

-- Escape a string so it is safe as a gsub *replacement* (only "%" is special).
local function esc_repl(s)
  return (s:gsub("%%", "%%%%"))
end

---Render a template string for a new note.
---Supported substitutions:
---  {{title}}, {{id}}
---  <% tp.file.creation_date("FMT") %>      (Obsidian Templater date, FMT optional)
---  <% tp.file.last_modified_date("FMT") %>
---  any key in config.placeholders (literal-string match)
---@param str string
---@param ctx { title: string, id: integer, now: integer }
---@return string
function M.render(str, ctx)
  local opts = config.options
  local now = ctx.now

  str = str:gsub("{{%s*title%s*}}", esc_repl(ctx.title))
  str = str:gsub("{{%s*id%s*}}", esc_repl(tostring(ctx.id)))

  -- Resolve the two Templater date helpers ourselves (no Templater in Neovim).
  local function date_sub(fn_name)
    -- With an explicit format argument.
    str = str:gsub(
      "<%%%s*tp%.file%." .. fn_name .. '%s*%(%s*["\']([^"\']*)["\']%s*%)%s*%%>',
      function(fmt)
        local sfmt = (fmt ~= "" and M.moment_to_strftime(fmt)) or opts.date_format
        return esc_repl(os.date(sfmt, now))
      end
    )
    -- No-argument form.
    str = str:gsub(
      "<%%%s*tp%.file%." .. fn_name .. "%s*%(%s*%)%s*%%>",
      esc_repl(os.date(opts.date_format, now))
    )
  end
  date_sub("creation_date")
  date_sub("last_modified_date")

  -- State-backed tokens: replace `currently_reading` / `current_topic` with a
  -- formatted link to the pointed-at note, or "" when none is set.
  local function state_link(key)
    local entry = state.get(key)
    if entry and entry.name and entry.name ~= "" then
      return opts.link_format(entry.name)
    end
    return ""
  end
  str = str:gsub("currently_reading", esc_repl(state_link("currently_reading")))
  str = str:gsub("current_topic", esc_repl(state_link("current_topic")))

  -- Custom, vault-specific placeholders.
  for key, val in pairs(opts.placeholders or {}) do
    local replacement = type(val) == "function" and (val(ctx) or "") or tostring(val)
    str = str:gsub(vim.pesc(key), esc_repl(replacement))
  end

  return str
end

return M
