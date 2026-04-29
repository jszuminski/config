return {
  "stevearc/oil.nvim",
  lazy = false,
  keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Open parent dir (oil)" },
    { "<leader>e", "<Cmd>Oil<CR>", desc = "File explorer (oil)" },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name)
        return name == ".." or name == ".DS_Store" or name == ".git"
      end,
    },
    win_options = {
      signcolumn = "yes:2",
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" } },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
    },
    use_default_keymaps = false,
  },
}
