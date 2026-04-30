return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    transparent = false,
    styles = {
      sidebars = "dark",
      floats = "dark",
      comments = { italic = true },
      keywords = { italic = false },
    },
    on_highlights = function(hl, c)
      local black = "#000000"
      local near_black = "#0a0a0a"
      local border = "#2a2a2a"

      hl.Normal = { bg = black, fg = c.fg }
      hl.NormalNC = { bg = black, fg = c.fg }
      hl.NormalFloat = { bg = black, fg = c.fg }
      hl.FloatBorder = { bg = black, fg = border }
      hl.FloatTitle = { bg = black, fg = c.orange, bold = true }

      hl.SignColumn = { bg = black }
      hl.SignColumnSB = { bg = black }
      hl.LineNr = { bg = black, fg = "#3a3a3a" }
      hl.CursorLineNr = { bg = black, fg = c.orange, bold = true }
      hl.CursorLine = { bg = near_black }
      hl.CursorColumn = { bg = near_black }
      hl.EndOfBuffer = { bg = black, fg = black }
      hl.WinSeparator = { fg = border, bg = black }
      hl.VertSplit = { fg = border, bg = black }

      hl.StatusLine = { bg = black, fg = c.fg }
      hl.StatusLineNC = { bg = black, fg = c.dark5 }
      hl.MsgArea = { bg = black, fg = c.fg }

      hl.Pmenu = { bg = black, fg = c.fg }
      hl.PmenuSel = { bg = "#1f1f1f", bold = true }
      hl.PmenuSbar = { bg = near_black }
      hl.PmenuThumb = { bg = border }

      hl.TabLine = { bg = black, fg = c.dark5 }
      hl.TabLineFill = { bg = black }
      hl.TabLineSel = { bg = black, fg = c.orange, bold = true }

      hl.Folded = { bg = near_black, fg = c.dark5 }
      hl.FoldColumn = { bg = black, fg = "#3a3a3a" }

      hl.TelescopeNormal = { bg = black, fg = c.fg }
      hl.TelescopeBorder = { bg = black, fg = border }
      hl.FzfLuaNormal = { bg = black, fg = c.fg }
      hl.FzfLuaBorder = { bg = black, fg = border }
      hl.FzfLuaTitle = { bg = black, fg = c.orange, bold = true }
      hl.FzfLuaPreviewNormal = { bg = black }
      hl.FzfLuaPreviewBorder = { bg = black, fg = border }

      hl.WhichKeyNormal = { bg = black }
      hl.WhichKeyBorder = { bg = black, fg = border }
      hl.WhichKeyFloat = { bg = black }

      hl.NoiceCmdlinePopup = { bg = black }
      hl.NoiceCmdlinePopupBorder = { bg = black, fg = border }

      hl.GitSignsAdd = { fg = c.green, bg = black }
      hl.GitSignsChange = { fg = c.yellow, bg = black }
      hl.GitSignsDelete = { fg = c.red, bg = black }

      hl.DiagnosticVirtualTextError = { bg = black, fg = c.red }
      hl.DiagnosticVirtualTextWarn = { bg = black, fg = c.yellow }
      hl.DiagnosticVirtualTextInfo = { bg = black, fg = c.blue }
      hl.DiagnosticVirtualTextHint = { bg = black, fg = c.cyan }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
