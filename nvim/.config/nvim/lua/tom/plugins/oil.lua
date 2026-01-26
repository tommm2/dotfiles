return {
	-- {
	-- 	"benomahony/oil-git.nvim",
	-- 	dependencies = { "stevearc/oil.nvim" },
	-- 	opts = {
	-- 		highlights = {
	-- 			OilGitAdded = { fg = "#81b88b" },
	-- 			OilGitModified = { fg = "#e2c08d" },
	-- 			OilGitDeleted = { fg = "#c74e39" },
	-- 			OilGitRenamed = { fg = "#73c991" },
	-- 			OilGitUntracked = { fg = "#73c991" },
	-- 			OilGitIgnored = { fg = "#8c8c8c" },
	-- 		},
	-- 	},
	-- },
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = true,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			function _G.get_oil_winbar()
				local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
				local dir = require("oil").get_current_dir(bufnr)
				if dir then
					return vim.fn.fnamemodify(dir, ":~")
				else
					return vim.api.nvim_buf_get_name(0)
				end
			end

			require("oil").setup({
				default_file_explorer = true,
				skip_confirm_for_simple_edits = true,
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name)
						local hidden = { ".git", "node_modules", ".DS_Store", "__pycache__", ".venv" }
						return vim.tbl_contains(hidden, name)
					end,
				},
				win_options = {
					winbar = "%!v:lua.get_oil_winbar()",
					wrap = false,
					signcolumn = "yes",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
				cleanup_delay_ms = 2000,
				lsp_file_methods = {
					autosave_changes = false,
				},
			})

			vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open Oil file explorer" })
			vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
}
