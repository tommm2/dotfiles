vim.g.mapleader = " "

local map = vim.keymap.set

local function opt(desc)
	return { noremap = true, silent = true, desc = desc }
end

map("n", "<leader>+", "<C-a>", opt("Increment number"))
map("n", "<leader>-", "<C-x>", opt("Decrement number"))
map("n", "<leader>w", ":w<CR>", opt("Save file"))
map("n", "<leader>q", ":q<CR>", opt("Close panel"))
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
-- map("n", "<leader>ql", function()
-- 	vim.diagnostic.setqflist({ open = true })
-- end, opt("Open quickfix list"))

-- Git
map("n", "<leader>gs", ":Git<CR>", opt("Git Status"))
map("n", "<leader>gc", ":Git commit<CR>", opt("Git Commit"))
map("n", "<leader>gP", ":Git pull --rebase<CR>", opt("Git Pull Rebase"))
map("n", "<leader>gp", ":Git push<CR>", opt("Git Push"))
map("n", "<leader>gb", ":Git blame<CR>", opt("Git Blame"))
map("n", "<leader>gh", ":0Gclog<CR>", opt("Git file History"))
map("n", "<leader>gw", ":Telescope git_worktree git_worktrees<CR>", opt("Git Switch Worktree"))
map("n", "<leader>gW", ":Telescope git_worktree create_git_worktree<CR>", opt("Git Create Worktree"))

-- Ctrl+hjkl moves between nvim windows; at the edge it hands off to herdr.
for key, dir in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	map("n", "<C-" .. key .. ">", function()
		local from = vim.api.nvim_get_current_win()
		vim.cmd.wincmd(key)
		local pane = vim.env.HERDR_PANE_ID
		if from == vim.api.nvim_get_current_win() and pane then
			vim.fn.jobstart(
				{ vim.env.HERDR_BIN_PATH or "herdr", "pane", "focus", "--pane", pane, "--direction", dir },
				{ detach = true }
			)
		end
	end, opt("Window/pane " .. dir))
end
