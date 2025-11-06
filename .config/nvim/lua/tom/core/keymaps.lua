-- define leader key
vim.g.mapleader = " "

local map = vim.keymap.set

local function opt(desc)
	return { noremap = true, silent = true, desc = desc }
end

map("n", "<leader>+", "<C-a>", opt("Increment number"))
map("n", "<leader>-", "<C-x>", opt("Decrement number"))
map("n", "<leader>w", ":w<CR>", opt("Save file"))
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-a>", "ggVG", opt("Select all"))

-- map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- window management
map("n", "<leader>sv", ":vsplit<CR>", opt("Vertical split"))
map("n", "<leader>sh", ":split<CR>", opt("Horizontal split"))
map("n", "<leader>se", ":<C-W>=", opt("Equal window size"))
map("n", "<leader>sx", ":close<CR>", opt("Close current window"))

map("n", "<C-d>", "<C-d>zz", opt("Page down"))
map("n", "<C-u>", "<C-u>zz", opt("Page up"))

-- terminal
map("t", "<esc>", [[<C-\><C-n>]])
map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", opt("Toggle vertical terminal"))
map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", opt("Toggle horizontal terminal"))

-- buffer
map("n", "<S-l>", ":bnext<CR>", opt("Next buffer"))
map("n", "<S-h>", ":bprevious<CR>", opt("Previous buffer"))
map("n", "<leader>bd", ":bdelete<CR>", opt("Delete buffer"))
map("n", "<leader>bD", ":bufdo bd<CR>", opt("Delete all buffers"))

-- quickfix
map("n", "<leader>ql", function()
	vim.diagnostic.setqflist({ open = true })
end, opt("Open quickfix list"))
