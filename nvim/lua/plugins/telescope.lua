return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git",
          "dist",
          "build"
        }, -- Ignore common large folders
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    })

    vim.keymap.set(
      "n",
      "<C-p>",
      ":Telescope find_files<CR>",
      { noremap = true, silent = true }
    )  -- Open file search

    vim.keymap.set(
      "n",
      "<C-g>",
      ":Telescope live_grep<CR>",
      { noremap = true, silent = true }
    )  -- Search inside files
  end,
}

