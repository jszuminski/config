-- To switch themes: change ACTIVE to "matrix", "vividchalk", "borlandp", or "ansi_blows".
local ACTIVE = "ansi_blows"

local function apply_matrix()
  vim.g.matrix_contrast = true
  vim.cmd.colorscheme("matrix")
  local black      = "#000000"
  local near_black = "#0a0a0a"
  local border     = "#2a2a2a"
  for group, opts in pairs({
    Normal                     = { bg = black },
    NormalNC                   = { bg = black },
    NormalFloat                = { bg = black },
    FloatBorder                = { bg = black, fg = border },
    SignColumn                 = { bg = black },
    LineNr                     = { bg = black },
    CursorLine                 = { bg = near_black },
    CursorColumn               = { bg = near_black },
    EndOfBuffer                = { bg = black, fg = black },
    WinSeparator               = { fg = border, bg = black },
    VertSplit                  = { fg = border, bg = black },
    StatusLine                 = { bg = black },
    StatusLineNC               = { bg = black },
    MsgArea                    = { bg = black },
    Pmenu                      = { bg = black },
    PmenuSel                   = { bg = "#1f1f1f", bold = true },
    PmenuSbar                  = { bg = near_black },
    PmenuThumb                 = { bg = border },
    TabLine                    = { bg = black },
    TabLineFill                = { bg = black },
    Folded                     = { bg = near_black },
    FoldColumn                 = { bg = black },
    FzfLuaNormal               = { bg = black },
    FzfLuaBorder               = { bg = black, fg = border },
    FzfLuaPreviewNormal        = { bg = black },
    FzfLuaPreviewBorder        = { bg = black, fg = border },
    WhichKeyNormal             = { bg = black },
    WhichKeyBorder             = { bg = black, fg = border },
    WhichKeyFloat              = { bg = black },
    GitSignsAdd                = { bg = black },
    GitSignsChange             = { bg = black },
    GitSignsDelete             = { bg = black },
    DiagnosticVirtualTextError = { bg = black },
    DiagnosticVirtualTextWarn  = { bg = black },
    DiagnosticVirtualTextInfo  = { bg = black },
    DiagnosticVirtualTextHint  = { bg = black },
  }) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

return {
  -- Both installed so switching is instant (just change ACTIVE above, restart).
  { "iruzo/matrix-nvim",           lazy = false, priority = 1000 },
  { "tpope/vim-vividchalk",        lazy = false, priority = 999  },
  { "caglartoklu/borlandp.vim",    lazy = false, priority = 998  },
  {
    "vim-scripts/ansi_blows.vim",
    lazy = false,
    priority = 997,
    -- config runs last; applies whichever theme is active.
    config = function()
      if ACTIVE == "matrix" then
        apply_matrix()
      elseif ACTIVE == "borlandp" then
        vim.g.borlandp_bg = "dark_blue"
        vim.cmd.colorscheme("borlandp")
      else
        vim.cmd.colorscheme(ACTIVE)
      end
    end,
  },
}
