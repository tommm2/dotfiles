local opt = vim.opt

vim.o.swapfile = false
vim.o.foldmethod = "expr"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.cmdheight = 1
vim.o.showmode = false
opt.relativenumber = true
opt.hidden = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.clipboard:append("unnamedplus")
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

