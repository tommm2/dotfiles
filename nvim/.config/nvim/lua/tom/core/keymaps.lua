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

-- Window management
map("n", "<leader>sv", ":vsplit<CR>", opt("Vertical split"))
map("n", "<leader>sh", ":split<CR>", opt("Horizontal split"))
map("n", "<leader>se", ":<C-W>=", opt("Equal window size"))
map("n", "<leader>sx", ":close<CR>", opt("Close current window"))

map("n", "<C-d>", "<C-d>zz", opt("Page down"))
map("n", "<C-u>", "<C-u>zz", opt("Page up"))

-- Terminal
map("t", "<esc>", [[<C-\><C-n>]])
map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", opt("Toggle vertical terminal"))
map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", opt("Toggle horizontal terminal"))

-- Buffer
map("n", "<S-l>", ":bnext<CR>", opt("Next buffer"))
map("n", "<S-h>", ":bprevious<CR>", opt("Previous buffer"))
map("n", "<leader>bd", ":bdelete<CR>", opt("Delete buffer"))
map("n", "<leader>bD", ":bufdo bd<CR>", opt("Delete all buffers"))

-- move line
map("n", "<A-j>", ":m .+1<CR>==", opt("Move line down"))
map("n", "<A-k>", ":m .-2<CR>==", opt("Move line up"))
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opt("Move selection down"))
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opt("Move selection up"))

-- quickfix
map("n", "<leader>ql", function()
	vim.diagnostic.setqflist({ open = true })
end, opt("Open quickfix list"))

-- Git
map("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git Commit" })
map("n", "<leader>gp", ":Git push<CR>", { desc = "Git Push" })
map("n", "<leader>gl", ":Git pull --rebase<CR>", { desc = "Git Pull Rebase" })
map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git Blame" })
map("n", "<leader>gw", ":Telescope git_worktree git_worktrees<CR>", { desc = "Switch Worktree" })
map("n", "<leader>gW", ":Telescope git_worktree create_git_worktree<CR>", { desc = "Create Worktree" })
