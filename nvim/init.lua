vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.cmd.colorscheme("retrobox")

-- Force pure black background
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#000000" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000", fg = "#000000" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
		"https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	checker = { enabled = false },
	change_detection = { notify = false },
})
