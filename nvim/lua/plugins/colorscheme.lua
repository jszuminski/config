return {
  "iruzo/matrix-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.matrix_contrast = true
    vim.cmd.colorscheme("matrix")

    local black = "#000000"
    local near_black = "#0a0a0a"
    local border = "#2a2a2a"

    local overrides = {
      Normal = { bg = black },
      NormalNC = { bg = black },
      NormalFloat = { bg = black },
      FloatBorder = { bg = black, fg = border },
      SignColumn = { bg = black },
      LineNr = { bg = black },
      CursorLine = { bg = near_black },
      CursorColumn = { bg = near_black },
      EndOfBuffer = { bg = black, fg = black },
      WinSeparator = { fg = border, bg = black },
      VertSplit = { fg = border, bg = black },
      StatusLine = { bg = black },
      StatusLineNC = { bg = black },
      MsgArea = { bg = black },
      Pmenu = { bg = black },
      PmenuSel = { bg = "#1f1f1f", bold = true },
      PmenuSbar = { bg = near_black },
      PmenuThumb = { bg = border },
      TabLine = { bg = black },
      TabLineFill = { bg = black },
      Folded = { bg = near_black },
      FoldColumn = { bg = black },
      FzfLuaNormal = { bg = black },
      FzfLuaBorder = { bg = black, fg = border },
      FzfLuaPreviewNormal = { bg = black },
      FzfLuaPreviewBorder = { bg = black, fg = border },
      WhichKeyNormal = { bg = black },
      WhichKeyBorder = { bg = black, fg = border },
      WhichKeyFloat = { bg = black },
      GitSignsAdd = { bg = black },
      GitSignsChange = { bg = black },
      GitSignsDelete = { bg = black },
      DiagnosticVirtualTextError = { bg = black },
      DiagnosticVirtualTextWarn = { bg = black },
      DiagnosticVirtualTextInfo = { bg = black },
      DiagnosticVirtualTextHint = { bg = black },
    }
    for group, opts in pairs(overrides) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end,
}
