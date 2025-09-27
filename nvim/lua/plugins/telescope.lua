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
					"build",
				}, -- Ignore common large folders
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
			},
		})

		-- Open file search (exactly like in VSC)
		vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })

		-- Search inside files (like Shift+Shift in Pycharm)
		vim.keymap.set("n", "<C-g>", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })

		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Telescope: go to definition" })

		-- Find all references of a method/variable the cursor's on
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", {
			desc = "LSP: Find references",
			noremap = true,
			silent = true,
		})
	end,
}
