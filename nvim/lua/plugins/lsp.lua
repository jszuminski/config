return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(_, bufnr)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end
				map("gd", vim.lsp.buf.definition, "Go to definition")
				map("gr", vim.lsp.buf.references, "References")
				map("K", vim.lsp.buf.hover, "Hover")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>d", vim.diagnostic.open_float, "Diagnostics")
			end

			-- TypeScript (vtsls — full-featured, tsgo still incomplete)
			lspconfig.vtsls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Python
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Rust
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Lua (for nvim config editing)
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
