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

local THEMES = {
  matrix = { "iruzo/matrix-nvim", apply = apply_matrix },
  vividchalk = { "tpope/vim-vividchalk", apply = function() vim.cmd.colorscheme("vividchalk") end },
  borlandp = {
    "caglartoklu/borlandp.vim",
    apply = function()
      vim.g.borlandp_bg = "dark_blue"
      vim.cmd.colorscheme("borlandp")
    end,
  },
  ansi_blows = { "vim-scripts/ansi_blows.vim", apply = function() vim.cmd.colorscheme("ansi_blows") end },
}

-- All themes stay installed so switching is instant (change ACTIVE, restart),
-- but only the active one is loaded and applied at startup.
local specs = {}
for name, theme in pairs(THEMES) do
  table.insert(specs, {
    theme[1],
    lazy = name ~= ACTIVE,
    priority = 1000,
    config = name == ACTIVE and function() theme.apply() end or nil,
  })
end
return specs
