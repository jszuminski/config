return {
	"christoomey/vim-tmux-navigator",
	keys = {
		{ "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", mode = { "n", "i" }, desc = "Tmux left" },
		{ "<C-j>", "<Cmd>TmuxNavigateDown<CR>", mode = { "n", "i" }, desc = "Tmux down" },
		{ "<C-k>", "<Cmd>TmuxNavigateUp<CR>", mode = { "n", "i" }, desc = "Tmux up" },
		{ "<C-l>", "<Cmd>TmuxNavigateRight<CR>", mode = { "n", "i" }, desc = "Tmux right" },
	},
}
