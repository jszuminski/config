vim.g.mapleader = " " -- can be used in keymaps as <leader>
vim.g.maplocalleader = "\\" -- can be used in keymaps as <localleader>

vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- relative line numbers

vim.opt.tabstop = 4 -- tab size
vim.opt.shiftwidth = 4 -- indent size
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- auto-indent

vim.opt.termguicolors = true -- enable true colors

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
-- binding to Command+C happens at terminal level (wezterm)
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Use Command + S to save files
vim.keymap.set("n", "<D-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("i", "<D-s>", "<Esc>:w<CR>a", { noremap = true, silent = true, desc = "Save file" })

-- Use Command + A to select everything in the current file
vim.keymap.set("n", "<D-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

require("config.lazy")
