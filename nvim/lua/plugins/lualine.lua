return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local black = "#000000"
    local theme = require("lualine.themes.tokyonight")
    for _, mode in pairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
      if theme[mode] then
        for _, section in pairs(theme[mode]) do
          section.bg = black
        end
      end
    end
    return {
    options = {
      theme = theme,
      globalstatus = true,
      component_separators = "",
      section_separators = "",
      disabled_filetypes = { statusline = { "dashboard", "alpha" } },
    },
    sections = {
      lualine_a = { { "mode", fmt = function(s) return s:sub(1, 1) end } },
      lualine_b = { "branch" },
      lualine_c = {
        { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
        { "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "[no name]" } },
      },
      lualine_x = {
        { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    }
  end,
}
