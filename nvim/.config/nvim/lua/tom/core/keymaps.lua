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
map("n", "<leader>gs", ":Git<CR>", opt("Git Status"))
map("n", "<leader>gc", ":Git commit<CR>", opt("Git Commit"))
map("n", "<leader>gP", ":Git pull --rebase<CR>", opt("Git Pull Rebase"))
map("n", "<leader>gp", ":Git push<CR>", opt("Git Push"))
map("n", "<leader>gb", ":Git blame<CR>", opt("Git Blame"))
map("n", "<leader>gh", ":0Gclog<CR>", opt("Git file History"))
map("n", "<leader>gw", ":Telescope git_worktree git_worktrees<CR>", opt("Git Switch Worktree"))
map("n", "<leader>gW", ":Telescope git_worktree create_git_worktree<CR>", opt("Git Create Worktree"))

-- Note
local note_dir = vim.fn.expand("$NOTE_DIR")
local tools_dir = vim.fn.expand("$TOOLS_DIR")

local function new_note(dir)
	local ts = os.date("%Y%m%d%H%M%S")
	vim.cmd("e " .. note_dir .. "/" .. dir .. "/new-" .. ts .. ".md")
end

map("n", "<leader>nf", function()
	require("telescope.builtin").live_grep({ search_dirs = { note_dir } })
end, opt("Search notes"))

map("n", "<leader>nb", function() new_note("bugs") end, opt("New bug note"))
map("n", "<leader>ni", function() new_note("ideas") end, opt("New idea note"))
map("n", "<leader>nd", function() new_note("docs") end, opt("New doc note"))

map("n", "<leader>nr", function()
	local file = vim.fn.expand("%:p")
	vim.cmd("w")

	local new_path = vim.fn.system(tools_dir .. "/note-rename.sh " .. vim.fn.shellescape(file))
	new_path = vim.fn.trim(new_path)

	if new_path ~= "" and not new_path:find("Error") then
		vim.cmd("e " .. new_path)
		vim.cmd("bd #")
		print("Renamed: " .. vim.fn.fnamemodify(new_path, ":t"))
	else
		print("Rename failed: " .. new_path)
	end
end, opt("AI generate filename"))
