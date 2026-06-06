return {
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  opts = {
    ring = {
      history_length = 100,
      storage = "shada", -- persists yank history across sessions, no extra deps
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 200, -- briefly flash yanked/put text
    },
  },
  keys = {
    -- route y / p / P through yanky so every yank is recorded in the ring
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before cursor" },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put after (cursor after text)" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put before (cursor after text)" },

    -- THE killer feature: right after a paste, cycle through older yanks.
    -- (Using [y / ]y because <C-p>/<C-n> are taken by fzf-lua in your config.)
    { "]y", "<Plug>(YankyCycleForward)", desc = "Yank ring: older entry" },
    { "[y", "<Plug>(YankyCycleBackward)", desc = "Yank ring: newer entry" },

    -- fuzzy-search your registers/yanks via your existing fzf-lua
    { "<leader>fy", function() require("fzf-lua").registers() end, desc = "Yanks / registers" },
  },
}
