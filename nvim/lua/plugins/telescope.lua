return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Live grep" },
		{ "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Buffers" },
		{ "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Help tags" },
		{ "<leader>fr", "<Cmd>Telescope oldfiles<CR>", desc = "Recent files" },
	},
}
