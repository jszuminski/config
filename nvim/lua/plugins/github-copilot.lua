return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 60,
				keymap = {
					accept = "<C-l>", -- @todo figure out what's the most convenient and fastest for me
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = {
				enabled = true,
			},
			filetypes = {
				markdown = true,
				python = true,
				javascript = true,
				typescript = true,
				html = true,
				tsx = true,
				jsx = true,
			},
			copilot_node_command = "node",
			server_opts_overrides = {
				settings = {
					model = "claude-3.7-sonnet",
				},
			},
		})
	end,
}
