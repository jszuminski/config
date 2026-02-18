return {
      "bluz71/vim-moonfly-colors",
        name = "moonfly",
          lazy = false,
            priority = 1000,
              config = function()
                      vim.cmd [[colorscheme moonfly]]
                        end,
                    }

-- return {
--  {
--    "nyoom-engineering/oxocarbon.nvim",
--     lazy     = false,     -- load at startup instead of “VeryLazy”
--    priority = 1000,      -- ensure it’s one of the first plugins on the rtp
--    config = function()
--      -- enable true‐color support
--      vim.opt.termguicolors = true 
--      vim.opt.background     = "dark"
--     -- apply the colorscheme
--      vim.cmd.colorscheme("oxocarbon")
--    end,
--  },
-- }

