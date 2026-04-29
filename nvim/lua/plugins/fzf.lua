return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader><space>", function() require("fzf-lua").files() end, desc = "Find files" },
    { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find files" },
    { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
    { "<leader>fG", function() require("fzf-lua").grep_cword() end, desc = "Grep word under cursor" },
    { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
    { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },
    { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Help" },
    { "<leader>fk", function() require("fzf-lua").keymaps() end, desc = "Keymaps" },
    { "<leader>fc", function() require("fzf-lua").commands() end, desc = "Commands" },
    { "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, desc = "Symbols (buffer)" },
    { "<leader>fS", function() require("fzf-lua").lsp_live_workspace_symbols() end, desc = "Symbols (workspace)" },
    { "<leader>fd", function() require("fzf-lua").diagnostics_workspace() end, desc = "Diagnostics" },
    { "<leader>/", function() require("fzf-lua").lgrep_curbuf() end, desc = "Grep in buffer" },
    { "<leader>gs", function() require("fzf-lua").git_status() end, desc = "Git status" },
    { "<leader>gc", function() require("fzf-lua").git_commits() end, desc = "Git commits" },
    { "<leader>gb", function() require("fzf-lua").git_branches() end, desc = "Git branches" },
  },
  opts = {
    "default-title",
    winopts = {
      height = 0.85,
      width = 0.85,
      preview = { default = "bat", scrollbar = false },
    },
    files = {
      formatter = "path.filename_first",
      git_icons = false,
    },
    grep = {
      rg_glob = true,
      glob_flag = "--iglob",
      glob_separator = "%s%-%-",
    },
    keymap = {
      builtin = { ["<C-/>"] = "toggle-help", ["<C-d>"] = "preview-page-down", ["<C-u>"] = "preview-page-up" },
      fzf = { ["ctrl-q"] = "select-all+accept" },
    },
  },
}
