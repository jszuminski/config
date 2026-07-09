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

    -- Fuzzy-search the yank *ring* (not Vim registers). Previously this
    -- called fzf-lua.registers(), which never saw Yanky's history.
    {
      "<leader>fy",
      function()
        local history = require("yanky.history").all()
        if #history == 0 then
          vim.notify("Yank history is empty", vim.log.levels.INFO)
          return
        end

        local entries = {}
        local by_label = {}
        for i, item in ipairs(history) do
          local text = item.regcontents or ""
          local oneline = (text:gsub("\n", "\\n")):sub(1, 120)
          local label = string.format("%3d  %s", i, oneline)
          entries[#entries + 1] = label
          by_label[label] = item
        end

        require("fzf-lua").fzf_exec(entries, {
          prompt = "Yank history> ",
          previewer = false,
          actions = {
            ["default"] = function(selected)
              local item = selected and by_label[selected[1]]
              if not item then
                return
              end
              -- Put the chosen ring entry after the cursor (same as YankyRingHistory).
              require("yanky.picker").actions.put("p")({
                regcontents = item.regcontents,
                regtype = item.regtype,
                filetype = item.filetype,
              })
            end,
          },
        })
      end,
      desc = "Yank history",
    },
  },
}
