return {
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = {
      -- Only used for its textobjects.scm query files, which the
      -- treesitter specs below read. Branch matches nvim-treesitter's.
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 300,
        custom_textobjects = {
          -- vaf/vif = around/inside function def, vac/vic = class,
          -- vao/vio = loop or conditional block. Defaults still provide
          -- a (argument), quotes, and brackets. g[ / g] jump to edges.
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          o = ai.gen_spec.treesitter({
            a = { "@conditional.outer", "@loop.outer" },
            i = { "@conditional.inner", "@loop.inner" },
          }),
        },
      }
    end,
  },
  {
    "echasnovski/mini.surround",
    keys = {
      { "gsa", desc = "Add surrounding", mode = { "n", "v" } },
      { "gsd", desc = "Delete surrounding" },
      { "gsr", desc = "Replace surrounding" },
    },
    opts = {
      -- Prefixed with `gs` (not `s`) so bare `s` keeps its built-in
      -- substitute-char behavior. `gs` only shadows the obscure sleep command.
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
}
