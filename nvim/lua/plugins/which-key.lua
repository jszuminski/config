return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>c", group = "code" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunk" },
      { "<leader>b", group = "buffer" },
      { "<leader>r", group = "rename" },
    },
  },
}
