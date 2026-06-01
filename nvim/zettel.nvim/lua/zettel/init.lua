local config = require("zettel.config")
local note = require("zettel.note")

local M = {}

---Public API: create a note of the given type (e.g. require("zettel").create("atom")).
M.create = note.create

---atom -> ZkAtom, molecule -> ZkMolecule
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

---@param opts? ZettelConfig
function M.setup(opts)
  config.setup(opts)

  -- One command per configured type, e.g. :ZkAtom, :ZkMolecule, :ZkAlloy.
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
end

return M
