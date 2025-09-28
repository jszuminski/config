return {
	"christoomey/vim-tmux-navigator",
	init = function()
		-- we'll provide our own mappings because of Claude Code workaround
		vim.g.tmux_navigator_no_mappings = 1
	end,
	keys = {
		{ "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", mode = { "n", "t" }, desc = "Tmux left" },
		{ "<C-j>", "<Cmd>TmuxNavigateDown<CR>", mode = { "n", "t" }, desc = "Tmux down" },
		{ "<C-k>", "<Cmd>TmuxNavigateUp<CR>", mode = { "n", "t" }, desc = "Tmux up" },
		{ "<C-l>", "<Cmd>TmuxNavigateRight<CR>", mode = { "n", "t" }, desc = "Tmux right" },
		{ "<C-\\>", "<Cmd>TmuxNavigatePrevious<CR>", mode = { "n", "t" }, desc = "Tmux prev" },
	},
}
