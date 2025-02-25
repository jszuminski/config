-- "brew install black"
-- "brew install isort"

return {
	"stevearc/conform.nvim",
	opts = {
		prettier = {
			prepend_args = function()
				return {
					"--config",
					"~/.config/nvim/prettier.config.js",
				}
			end,
			config_command = "--config",
			config_names = {
				"prettier.config.js",
				".prettierrc",
				".prettierrc.js",
				".prettierrc.json",
				".prettierrc.yaml",
				".prettierrc.yml",
			},
			config_path = ".prettierrc.json",
		},
	},
	config = function()
		-- Conform will run multiple formatters sequentially
		require("conform").setup({
			format_on_save = {
				enabled = true,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = {
					"stylua",
				},
				python = {
					"isort",
					"black",
				},
				javascript = {
					"prettier",
				},
			},
		})
	end,
}
