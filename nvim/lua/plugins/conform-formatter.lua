return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = {
				enabled = true,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettier" },
			},
			formatters = {
				prettier = {
					args = function(self, ctx)
						local check_cwd = require("conform.util").root_file({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.yml",
							".prettierrc.yaml",
							".prettierrc.json5",
							".prettierrc.js",
							".prettierrc.cjs",
							".prettierrc.mjs",
							".prettierrc.toml",
							"prettier.config.js",
							"prettier.config.cjs",
							"prettier.config.mjs",
						})

						local found = check_cwd(self, ctx)
						local bufnr = ctx.bufnr or 0
						local filename = vim.api.nvim_buf_get_name(bufnr)

						if found then
							vim.notify("Found local config file: " .. vim.inspect(found), vim.log.levels.INFO)
						else
							vim.notify("No local config file found, using global config", vim.log.levels.INFO)
						end

						if not found then
							return {
								"--stdin-filepath",
								filename,
								"--config",
								os.getenv("HOME") .. "/.config/nvim/formatters/prettier.config.js",
							}
						end

						return { "--stdin-filepath", filename }
					end,
				},
			},
		})
	end,
}
