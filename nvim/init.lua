vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 2 -- Tab size
vim.opt.shiftwidth = 2 -- Indent size
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Auto-indent
vim.opt.termguicolors = true -- Enable true colors

-- Do not go back to normal mode after changing tabs
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })

-- Disable auto-continuation of comments
---- c -> auto wraps comments
---- r -> automatically insert current comment leader after <Enter>
---- o -> Automatically insert current comment leader after <o>
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Actually make Ctrl+C copy to clipboard inside nvim
-- binding to Command+C happens at terminal level (iterm2 keyboard settings)
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

require("config.lazy")
