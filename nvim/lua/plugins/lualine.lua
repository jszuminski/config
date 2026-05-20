return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local black = "#000000"
    local green = "#00FF41"
    local dim = "#226622"
    local fg = "#55ff55"
    local grey = "#444444"
    local yellow = "#cccc00"
    local red = "#cc0000"

    local theme = {
      normal   = { a = { bg = black, fg = green, gui = "bold" }, b = { bg = black, fg = fg }, c = { bg = black, fg = dim } },
      insert   = { a = { bg = black, fg = green, gui = "bold" }, b = { bg = black, fg = fg }, c = { bg = black, fg = dim } },
      visual   = { a = { bg = black, fg = yellow, gui = "bold" }, b = { bg = black, fg = fg }, c = { bg = black, fg = dim } },
      replace  = { a = { bg = black, fg = red, gui = "bold" }, b = { bg = black, fg = fg }, c = { bg = black, fg = dim } },
      command  = { a = { bg = black, fg = green, gui = "bold" }, b = { bg = black, fg = fg }, c = { bg = black, fg = dim } },
      inactive = { a = { bg = black, fg = grey }, b = { bg = black, fg = grey }, c = { bg = black, fg = grey } },
    }
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
