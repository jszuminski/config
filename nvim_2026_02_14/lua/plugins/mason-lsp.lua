-- "brew install basedpyright" in order for it to work

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/nvim-cmp", -- autocompletions
		"hrsh7th/cmp-nvim-lsp", -- lsp source for nvim-cmp
		"williamboman/mason.nvim", -- lsp manager
		"williamboman/mason-lspconfig.nvim", -- mason-lsp bridge
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"html",
				"cssls",
				"ts_ls",
				"basedpyright",
				"tailwindcss",
				"rust_analyzer",
				"clangd", -- C/C++
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")

		------------------------------------------------------------------------
		-- Global diagnostics UI (nice defaults)
		------------------------------------------------------------------------
		-- Signs in the gutter
		vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint" })

		-- Virtual text, underline, sorting, floating window style
		vim.diagnostic.config({
			virtual_text = {
				prefix = "--",
				spacing = 4,
			},
			underline = true,
			severity_sort = true,
			update_in_insert = false,
			float = {
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "",
			},
		})

		-- Handy diagnostic keymaps
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

		-- on_attach: buffer-local LSP keymaps (add more if you like)
		local on_attach = function(_, bufnr)
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			map("n", "K", vim.lsp.buf.hover, "Hover")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
			map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

			-- Inlay hints (Neovim 0.10+)
			if vim.lsp.inlay_hint then
				map("n", "<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(bufnr), { bufnr = bufnr })
				end, "Toggle inlay hints")
			end
		end

		------------------------------------------------------------------------
		-- Servers
		------------------------------------------------------------------------
		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			},
		})

		lspconfig.basedpyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				basedpyright = {
					analysis = {
						typeCheckingMode = "strict",
						diagnosticMode = "workspace",
					},
				},
			},
		})

		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						enable = true,
						disabled = {},
						warningsAsHint = {},
						warningsAsInfo = {},
					},
					cargo = {
						allFeatures = true,
					},
					inlayHints = {
						lifetimeElisionHints = { enable = "always" },
						bindingModeHints = { enable = true },
					},
				},
			},
		})
	end,
}
