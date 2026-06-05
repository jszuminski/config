local aug = vim.api.nvim_create_augroup("jacob", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = aug,
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = aug,
  command = "tabdo wincmd =",
})

vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = { "help", "qf", "man", "lspinfo", "checkhealth" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = aug,
  callback = function()
    if vim.fn.mode() ~= "c" and vim.api.nvim_get_mode().mode ~= "t" then
      pcall(vim.cmd, "checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = aug,
  callback = function()
    vim.notify("File changed on disk - buffer reloaded", vim.log.levels.INFO)
  end,
})

-- Soft-wrap prose filetypes. Uses BufWinEnter as well as FileType because
-- wrap/linebreak/breakindent are window-local: FileType alone only sets them
-- on first load, so a re-displayed already-loaded buffer (e.g. returning to a
-- file after renaming it in oil) would keep the global `nowrap`. BufWinEnter
-- fires per window, closing that gap.
--
-- NOTE: no `pattern` here. For BufWinEnter the pattern matches the file *name*,
-- not the filetype, so a filetype pattern would silently disable that half.
-- We let both events fire for everything and gate on the filetype inside.
local wrap_filetypes = { markdown = true, text = true, gitcommit = true, mail = true }
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  group = aug,
  callback = function()
    if not wrap_filetypes[vim.bo.filetype] then
      return
    end
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})
