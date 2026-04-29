return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  init = function()
    vim.g.tmux_navigator_no_mappings = 0
    vim.g.tmux_navigator_disable_when_zoomed = 1
  end,
  config = function()
    local map = vim.keymap.set
    map("i", "<C-h>", "<Esc><Cmd>TmuxNavigateLeft<CR>", { silent = true, desc = "Tmux left" })
    map("i", "<C-j>", "<Esc><Cmd>TmuxNavigateDown<CR>", { silent = true, desc = "Tmux down" })
    map("i", "<C-k>", "<Esc><Cmd>TmuxNavigateUp<CR>", { silent = true, desc = "Tmux up" })
    map("i", "<C-l>", "<Esc><Cmd>TmuxNavigateRight<CR>", { silent = true, desc = "Tmux right" })
    map("t", "<C-h>", [[<C-\><C-n><Cmd>TmuxNavigateLeft<CR>]], { silent = true, desc = "Tmux left" })
    map("t", "<C-j>", [[<C-\><C-n><Cmd>TmuxNavigateDown<CR>]], { silent = true, desc = "Tmux down" })
    map("t", "<C-k>", [[<C-\><C-n><Cmd>TmuxNavigateUp<CR>]], { silent = true, desc = "Tmux up" })
    map("t", "<C-l>", [[<C-\><C-n><Cmd>TmuxNavigateRight<CR>]], { silent = true, desc = "Tmux right" })
  end,
}
