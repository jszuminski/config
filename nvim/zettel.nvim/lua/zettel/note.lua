local config = require("zettel.config")
local id_mod = require("zettel.id")
local template = require("zettel.template")
local frontmatter = require("zettel.frontmatter")
local state = require("zettel.state")

local M = {}

local function notify(msg, level)
  vim.notify("[zettel] " .. msg, level or vim.log.levels.INFO)
end

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

---@param type_cfg ZettelTypeConfig
---@return string|nil
local function read_template(type_cfg)
  if not type_cfg.template then
    return nil
  end
  local tpl_path = vim.fs.joinpath(config.options.vault, type_cfg.template)
  local ok, lines = pcall(vim.fn.readfile, tpl_path)
  if not ok then
    notify("could not read template, using a plain heading: " .. tpl_path, vim.log.levels.WARN)
    return nil
  end
  return table.concat(lines, "\n")
end

---Sequentially prompt for a type's extra fields. Calls `done(values)` where
---values maps field key -> string (or string[] for `list` fields). Skipped
---empty fields are omitted entirely so the template default is kept.
---@param fields ZettelField[]
---@param done fun(values: table)
local function prompt_fields(fields, done)
  local acc = {}
  local function step(i)
    if i > #fields then
      return done(acc)
    end
    local f = fields[i]
    local function commit(value)
      if value ~= nil and value ~= "" then
        if f.list then
          acc[f.key] = vim.tbl_map(vim.trim, vim.split(value, ",", { trimempty = true }))
        else
          acc[f.key] = value
        end
      end
      step(i + 1)
    end
    if f.type == "select" and f.choices then
      vim.ui.select(f.choices, { prompt = f.prompt }, function(choice)
        commit(choice or f.default)
      end)
    else
      vim.ui.input({ prompt = f.prompt .. ": ", default = f.default or "" }, commit)
    end
  end
  step(1)
end

---If the type declares `set_reading_when` and the matching field value was
---chosen, point "currently reading" at the freshly created note.
local function maybe_set_reading(type_cfg, values, name, path)
  local cond = type_cfg.set_reading_when
  if not cond or not cond.field then
    return
  end
  local v = values[cond.field]
  if v == nil then
    return
  end
  local matches = (type(v) == "table") and vim.tbl_contains(v, cond.equals) or (v == cond.equals)
  if matches then
    state.set("currently_reading", { name = name, path = path })
    notify("set as currently reading: " .. name)
  end
end

---Create a new note of the given type: prompt for title and any configured
---fields, compute the next ID, render the template, fill frontmatter, write
---and open.
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

    prompt_fields(type_cfg.fields or {}, function(values)
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

      local content = read_template(type_cfg)
      if content then
        content = template.render(content, { title = title, id = id, now = os.time() })
        content = frontmatter.fill(content, values)
      else
        content = "# " .. title .. "\n"
      end

      local ok, err = pcall(vim.fn.writefile, vim.split(content, "\n"), path)
      if not ok then
        notify("failed to write note: " .. tostring(err), vim.log.levels.ERROR)
        return
      end

      maybe_set_reading(type_cfg, values, (filename:gsub("%.md$", "")), path)

      vim.cmd(string.format("%s %s", opts.open or "edit", vim.fn.fnameescape(path)))
      notify("created " .. filename)
    end)
  end)
end

return M
