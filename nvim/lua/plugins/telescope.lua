return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Grep" },
		{ "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Buffers" },
	},
}
