local config = require("zettel.config")
local id_mod = require("zettel.id")
local template = require("zettel.template")

local M = {}

local function notify(msg, level)
  vim.notify("[zettel] " .. msg, level or vim.log.levels.INFO)
end

---Resolve the absolute folder for a note type.
---@param type_cfg ZettelTypeConfig
---@return string
local function resolve_folder(type_cfg)
  local opts = config.options
  local rel = type_cfg.folder or opts.folder or ""
  if rel == "" then
    return opts.vault
  end
  return vim.fs.joinpath(opts.vault, rel)
end

---Build the note body, from the type's template if it has one.
---@param type_cfg ZettelTypeConfig
---@param ctx { title: string, id: integer, now: integer }
---@return string
local function build_content(type_cfg, ctx)
  if not type_cfg.template then
    return "# " .. ctx.title .. "\n"
  end
  local opts = config.options
  local tpl_path = vim.fs.joinpath(opts.vault, type_cfg.template)
  local ok, lines = pcall(vim.fn.readfile, tpl_path)
  if not ok then
    notify("could not read template, using a plain heading: " .. tpl_path, vim.log.levels.WARN)
    return "# " .. ctx.title .. "\n"
  end
  return template.render(table.concat(lines, "\n"), ctx)
end

---Create a new note of the given type. Prompts for the title, computes the next
---ID for the type's folder, renders the template, writes the file and opens it.
---@param type_name string
function M.create(type_name)
  local opts = config.options

  if not opts.vault or opts.vault == "" then
    notify("no vault configured; call require('zettel').setup{ vault = ... }", vim.log.levels.ERROR)
    return
  end

  local type_cfg = (opts.types or {})[type_name]
  if not type_cfg then
    notify("unknown note type: " .. tostring(type_name), vim.log.levels.ERROR)
    return
  end

  vim.ui.input({ prompt = "New " .. type_name .. " title: " }, function(input)
    if not input or vim.trim(input) == "" then
      return
    end
    local title = vim.trim(input)

    local folder = resolve_folder(type_cfg)
    if vim.fn.isdirectory(folder) == 0 then
      vim.fn.mkdir(folder, "p")
    end

    local id = id_mod.next_id(folder, opts.id_separator, {
      recursive = opts.recursive,
      id_start = opts.id_start,
    })

    local filename = string.format("%d%s %s.md", id, opts.id_separator, title)
    local path = vim.fs.joinpath(folder, filename)

    if vim.fn.filereadable(path) == 1 then
      notify("refusing to overwrite existing file: " .. path, vim.log.levels.ERROR)
      return
    end

    local content = build_content(type_cfg, { title = title, id = id, now = os.time() })

    local write_ok, err = pcall(vim.fn.writefile, vim.split(content, "\n"), path)
    if not write_ok then
      notify("failed to write note: " .. tostring(err), vim.log.levels.ERROR)
      return
    end

    vim.cmd(string.format("%s %s", opts.open or "edit", vim.fn.fnameescape(path)))
    notify(string.format("created %s", filename))
  end)
end

return M
