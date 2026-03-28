return {
	"christoomey/vim-tmux-navigator",
	keys = {
		{ "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", mode = { "n", "i", "t" }, desc = "Tmux left" },
		{ "<C-j>", "<Cmd>TmuxNavigateDown<CR>", mode = { "n", "i", "t" }, desc = "Tmux down" },
		{ "<C-k>", "<Cmd>TmuxNavigateUp<CR>", mode = { "n", "i", "t" }, desc = "Tmux up" },
		{ "<C-l>", "<Cmd>TmuxNavigateRight<CR>", mode = { "n", "i", "t" }, desc = "Tmux right" },
	},
}
