vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 2 -- Tab size
vim.opt.shiftwidth = 2 -- Indent size
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Auto-indent
vim.opt.termguicolors = true -- Enable true colors

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

-- If there's only NvimTree left after hitting :q, quick the editor.
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
      vim.cmd("quit")
    end
  end,
})

-- Actually make Ctrl+C copy to clipboard inside nvim
-- @TODO: This doesn't work
vim.keymap.set("v", "<leader>c", '"+y', { noremap = true, silent = true })

require("config.lazy")

