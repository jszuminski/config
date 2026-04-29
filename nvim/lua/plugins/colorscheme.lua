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
      hl.LineNr = { fg = c.dark5 }
      hl.CursorLineNr = { fg = c.orange, bold = true }
      hl.WinSeparator = { fg = c.bg_dark, bg = "NONE" }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
