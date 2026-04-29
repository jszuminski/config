local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.pumheight = 12

opt.splitright = true
opt.splitbelow = true

opt.clipboard = "unnamedplus"
opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.updatetime = 200
opt.timeoutlen = 400

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("WcC")
opt.fillchars = { eob = " " }

opt.confirm = true
