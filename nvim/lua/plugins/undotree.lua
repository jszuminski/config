-- Browse the persistent undo history (undofile is enabled in options.lua,
-- so this reaches back across sessions, not just the current one).
return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle", "UndotreeShow" },
  keys = {
    { "<leader>uu", "<Cmd>UndotreeToggle<CR>", desc = "Undo tree" },
  },
  init = function()
    vim.g.undotree_WindowLayout = 2 -- tree left, diff at the bottom
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
