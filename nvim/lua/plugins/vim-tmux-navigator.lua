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
    -- Disable plugin's auto-installed C-hjkl mappings; we install our own
    -- below so we can short-circuit in buffer-only UIs (oil, lazy, etc).
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_disable_when_zoomed = 1
  end,
  config = function()
    -- Filetypes where ALL C-hjkl stay inside the buffer.
    local block_all = {
      lazy = true,
      mason = true,
      help = true,
      oil = true,
    }

    local function nav(direction)
      return function()
        if block_all[vim.bo.filetype] then return end
        vim.cmd("TmuxNavigate" .. direction)
      end
    end

    local map = vim.keymap.set
    map("n", "<C-h>", nav("Left"),  { silent = true, desc = "Nav left (split or tmux)" })
    map("n", "<C-j>", nav("Down"),  { silent = true, desc = "Nav down (split or tmux)" })
    map("n", "<C-k>", nav("Up"),    { silent = true, desc = "Nav up (split or tmux)" })
    map("n", "<C-l>", nav("Right"), { silent = true, desc = "Nav right (split or tmux)" })

    map("i", "<C-h>", "<Esc><Cmd>TmuxNavigateLeft<CR>",  { silent = true, desc = "Tmux left" })
    map("i", "<C-j>", "<Esc><Cmd>TmuxNavigateDown<CR>",  { silent = true, desc = "Tmux down" })
    map("i", "<C-k>", "<Esc><Cmd>TmuxNavigateUp<CR>",    { silent = true, desc = "Tmux up" })
    map("i", "<C-l>", "<Esc><Cmd>TmuxNavigateRight<CR>", { silent = true, desc = "Tmux right" })

    -- Terminal mode mappings deliberately omitted: fzf-lua, lazygit, htop
    -- and other TUI programs running in :term need C-hjkl for their own
    -- navigation. To switch panes from a real shell in :term, exit terminal
    -- mode first with <C-\><C-n>.
  end,
}
