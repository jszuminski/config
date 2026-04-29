local map = vim.keymap.set

map("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<leader>w", "<Cmd>write<CR>", { desc = "Save" })
map("n", "<leader>q", "<Cmd>confirm quit<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<Cmd>confirm qall<CR>", { desc = "Quit all" })

map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

map("v", "<", "<gv", { desc = "Indent left, keep selection" })
map("v", ">", ">gv", { desc = "Indent right, keep selection" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

map("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<S-h>", "<Cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Next buffer" })

map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
