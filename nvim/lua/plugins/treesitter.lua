return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	config = function()
		-- Install parsers (nvim 0.11 handles highlighting natively)
		require("nvim-treesitter").install({
			"typescript", "tsx", "javascript",
			"python",
			"rust",
			"lua",
			"json", "yaml", "toml",
			"html", "css",
			"bash",
			"markdown", "markdown_inline",
		})
	end,
}
