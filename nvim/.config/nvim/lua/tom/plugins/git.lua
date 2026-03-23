return {
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{
		"ThePrimeagen/git-worktree.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("git-worktree").setup({})
			require("telescope").load_extension("git_worktree")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs_staged_enable = false,
		},
	},
}
