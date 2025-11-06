return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			enable_git_status = true,
			enable_diagnositcs = true,
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				hijack_netrw_behavior = "open_current",
			},

			-- components config
			default_component_configs = {
				indent = { padding = 1 },
				icon = { folder_closed = "", folder_open = "", folder_empty = "" },
				git_status = {
					symbols = {
						added = "A",
						modified = "M",
						deleted = "D",
						renamed = "R",
						untracked = "U",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "C",
					},
				},
			},
		})

		-- custom color
		local setHl = vim.api.nvim_set_hl

		setHl(0, "NeoTreeGitUntracked", { fg = "#8bc34b", bg = "NONE" })

		local keymap = vim.keymap.set
		keymap("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
	end,
}

-- return {
-- 	{
-- 		"benomahony/oil-git.nvim",
-- 		dependencies = { "stevearc/oil.nvim" },
-- 		opts = {
-- 			highlights = {
-- 				OilGitUntracked = { fg = "#8bc34b" },
-- 				OilGitAdded = { fg = "#81b98b" },
-- 				OilGitModified = { fg = "#ffca27" },
-- 				OilGitRenamed = { fg = "#81b98b" },
-- 				OilGitIgnored = { fg = "#69777a" },
-- 			},
-- 		},
-- 	},
-- 	{
-- 		"stevearc/oil.nvim",
-- 		event = "VeryLazy",
-- 		config = function()
-- 			function _G.get_oil_winbar()
-- 				local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
-- 				local dir = require("oil").get_current_dir(bufnr)
-- 				if dir then
-- 					return vim.fn.fnamemodify(dir, ":~")
-- 				else
-- 					return vim.api.nvim_buf_get_name(0)
-- 				end
-- 			end
--
-- 			require("oil").setup({
-- 				view_options = {
-- 					show_hidden = true,
-- 				},
-- 				win_options = {
-- 					winbar = "%!v:lua.get_oil_winbar()",
-- 					wrap = false,
-- 					signcolumn = "no",
-- 					cursorcolumn = false,
-- 					foldcolumn = "0",
-- 					spell = false,
-- 					list = false,
-- 					conceallevel = 3,
-- 					concealcursor = "nvic",
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
