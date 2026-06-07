return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  -- opts is a function so `require("obsidian.builtin")` resolves only after
  -- the plugin is on the runtimepath (avoids a load-order error at startup).
  opts = function()
    return {
      legacy_commands = false,
      workspaces = {
        { name = "jsafe", path = "~/Documents/jsafe" },
      },

      -- SAFETY: never inject/normalize YAML frontmatter in existing notes.
      -- The vault has 1100+ notes with mixed/no frontmatter; this keeps the
      -- plugin read-only with respect to file headers.
      frontmatter = { enabled = false },

      -- Readable slug filenames for notes created via `[[` completion,
      -- instead of random zettel IDs.
      note_id_func = require("obsidian.builtin").title_id,

      -- Don't drop daily notes into the vault root.
      daily_notes = { enabled = false },

      -- `[[` link + `#` tag completion (served via obsidian's in-process LSP).
      completion = {
        min_chars = 1,
        create_new = true,
      },

      ui = { enable = false },
      picker = { name = "fzf-lua" },
      templates = { folder = "_templates" },
      attachments = { folder = "_attachments" },
    }
  end,
  keys = {
    { "<leader>oo", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Links in buffer" },
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch note" },
  },
}
