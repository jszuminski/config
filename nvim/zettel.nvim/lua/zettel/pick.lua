-- Note picker. Prefers fzf-lua (if installed) and falls back to vim.ui.select,
-- so the plugin has no hard dependency on any picker.
local M = {}

---List markdown notes in a folder.
---@param folder string Absolute folder path.
---@param recursive? boolean Defaults to true.
---@return { name: string, path: string }[]
function M.list_notes(folder, recursive)
  local notes = {}
  local depth = recursive == false and 1 or 100
  local ok, iter = pcall(vim.fs.dir, folder, { depth = depth })
  if not ok or not iter then
    return notes
  end
  for name, type_ in iter do
    if type_ == "file" and name:sub(-3) == ".md" then
      notes[#notes + 1] = {
        name = (vim.fs.basename(name):gsub("%.md$", "")),
        path = vim.fs.joinpath(folder, name),
      }
    end
  end
  table.sort(notes, function(a, b)
    return a.name < b.name
  end)
  return notes
end

---Pick a note from a folder, then invoke on_choice with { name, path }.
---@param folder string
---@param prompt string
---@param on_choice fun(note: { name: string, path: string })
function M.pick_note(folder, prompt, on_choice)
  local notes = M.list_notes(folder)
  if #notes == 0 then
    vim.notify("[zettel] no notes found in " .. tostring(folder), vim.log.levels.WARN)
    return
  end

  local has_fzf, fzf = pcall(require, "fzf-lua")
  if has_fzf then
    local by_name = {}
    local names = {}
    for _, n in ipairs(notes) do
      by_name[n.name] = n
      names[#names + 1] = n.name
    end
    fzf.fzf_exec(names, {
      prompt = prompt .. "> ",
      actions = {
        ["default"] = function(selected)
          local choice = selected and selected[1]
          if choice and by_name[choice] then
            on_choice(by_name[choice])
          end
        end,
      },
    })
  else
    vim.ui.select(notes, {
      prompt = prompt,
      format_item = function(n)
        return n.name
      end,
    }, function(choice)
      if choice then
        on_choice(choice)
      end
    end)
  end
end

return M
