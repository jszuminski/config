-- use the "+" register for ALL yanks/delets/put-ops
vim.opt.clipboard:prepend({ "unnamedplus" })

local map = vim.keymap.set

-- good noremap explanation: https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping
-- silent: executes command silently, without any user messages
local opts = { noremap = true, silent = true }

map("v", "<C-c>", '"+y', opts) -- visual: copy selection
map("n", "<C-c>", '"+yy', opts) -- normal: copy current line

map({ "n", "v" }, "<C-v>", '"+p', opts) -- normal/visual: paste before cursor
map("i", "<C-v>", '<C-r>+', opts) -- insert/command: paste from clipboard
map("c", "<C-v>", '<C-r>+', opts)

-- prevent overwriting the clipboard when pasting over a visual selection
map("x", "p", '"_dP', opts)


