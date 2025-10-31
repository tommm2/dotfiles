-- return {
-- 	"nvim-neo-tree/neo-tree.nvim",
-- 	branch = "v3.x",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"MunifTanjim/nui.nvim",
-- 		"nvim-tree/nvim-web-devicons",
-- 	},
-- 	lazy = false,
-- 	config = function()
-- 		require("neo-tree").setup({
-- 			close_if_last_window = true,
-- 			enable_git_status = true,
-- 			enable_diagnositcs = true,
-- 			filesystem = {
-- 				filtered_items = {
-- 					visible = true,
-- 					hide_dotfiles = false,
-- 					hide_gitignored = true,
-- 				},
-- 				follow_current_file = {
-- 					enabled = true,
-- 					leave_dirs_open = true,
-- 				},
-- 				hijack_netrw_behavior = "open_current",
-- 			},
--
-- 			-- components config
-- 			default_component_configs = {
-- 				indent = { padding = 1 },
-- 				icon = { folder_closed = "", folder_open = "", folder_empty = "" },
-- 				git_status = {
-- 					symbols = {
-- 						added = "A",
-- 						modified = "M",
-- 						deleted = "D",
-- 						renamed = "R",
-- 						untracked = "U",
-- 						ignored = "",
-- 						unstaged = "",
-- 						staged = "",
-- 						conflict = "C",
-- 					},
-- 				},
-- 			},
-- 		})
--
-- 		-- custom color
-- 		local setHl = vim.api.nvim_set_hl
--
-- 		setHl(0, "NeoTreeGitUntracked", { fg = "#8bc34b", bg = "NONE" })
--
-- 		local keymap = vim.keymap.set
-- 		keymap("n", "<leader>ee", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
-- 		keymap("n", "<leader>ef", "<cmd>Neotree reveal<CR>", { desc = "Focus current file in Neo-tree" })
-- 	end,
-- }

return {
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {
			highlights = {
				OilGitUntracked = { fg = "#8bc34b" },
				OilGitAdded = { fg = "#81b98b" },
				OilGitModified = { fg = "#ffca27" },
				OilGitRenamed = { fg = "#81b98b" },
				OilGitIgnored = { fg = "#69777a" },
			},
		},
	},
	{
		"stevearc/oil.nvim",
		event = "VeryLazy",
		config = function()
			require("oil").setup({
				win_options = {
					wrap = false,
					signcolumn = "no",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
			})
		end,
	},
}
