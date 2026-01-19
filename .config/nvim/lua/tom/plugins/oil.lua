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
				view_options = {
					show_hidden = true,
				},
				win_options = {
					winbar = "%!v:lua.get_oil_winbar()",
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

			vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open Oil file explorer" })
			vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
}
