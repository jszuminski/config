local config = require("zettel.config")
local note = require("zettel.note")
local pick = require("zettel.pick")
local state = require("zettel.state")

local M = {}

---Public API: create a note of the given type, e.g. require("zettel").create("atom").
M.create = note.create

---atom -> ZkAtom, literature -> ZkLiterature
---@param type_name string
---@return string
local function cmd_name(type_name)
  return "Zk" .. type_name:sub(1, 1):upper() .. type_name:sub(2)
end

---@return string[]
local function sorted_types()
  local types = vim.tbl_keys(config.options.types or {})
  table.sort(types)
  return types
end

---Resolve a vault-relative folder to an absolute path.
---@param rel? string
---@return string
local function abspath(rel)
  local vault = config.options.vault
  if not rel or rel == "" then
    return vault
  end
  return vim.fs.joinpath(vault, rel)
end

---Pick and store the currently-reading note.
function M.set_reading()
  pick.pick_note(abspath(config.options.reading_folder), "Currently reading", function(n)
    state.set("currently_reading", { name = n.name, path = n.path })
    vim.notify("[zettel] currently reading: " .. n.name)
  end)
end

---Pick and store the current-topic note (defaults to picking from the whole vault).
function M.set_topic()
  pick.pick_note(abspath(config.options.topic_folder), "Current topic", function(n)
    state.set("current_topic", { name = n.name, path = n.path })
    vim.notify("[zettel] current topic: " .. n.name)
  end)
end

---Open the currently-reading note, if one is set.
function M.open_reading()
  local entry = state.get("currently_reading")
  if not entry or not entry.path then
    vim.notify("[zettel] no currently-reading note set", vim.log.levels.WARN)
    return
  end
  vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
end

---@param opts? ZettelConfig
function M.setup(opts)
  config.setup(opts)

  -- One command per configured type, e.g. :ZkAtom, :ZkMolecule, :ZkLiterature.
  for type_name in pairs(config.options.types or {}) do
    vim.api.nvim_create_user_command(cmd_name(type_name), function()
      note.create(type_name)
    end, { desc = "Create a new " .. type_name .. " note" })
  end

  -- :Zk [type] — create a note, picking the type interactively if omitted.
  vim.api.nvim_create_user_command("Zk", function(args)
    if args.args ~= "" then
      note.create(args.args)
      return
    end
    local types = sorted_types()
    if #types == 0 then
      vim.notify("[zettel] no note types configured", vim.log.levels.WARN)
      return
    end
    vim.ui.select(types, { prompt = "Note type:" }, function(choice)
      if choice then
        note.create(choice)
      end
    end)
  end, {
    nargs = "?",
    desc = "Create a new Zettelkasten note (optionally pass a type)",
    complete = sorted_types,
  })

  vim.api.nvim_create_user_command("ZkSetReading", M.set_reading, { desc = "Set the currently-reading note" })
  vim.api.nvim_create_user_command("ZkSetTopic", M.set_topic, { desc = "Set the current-topic note" })
  vim.api.nvim_create_user_command("ZkReading", M.open_reading, { desc = "Open the currently-reading note" })
end

return M
