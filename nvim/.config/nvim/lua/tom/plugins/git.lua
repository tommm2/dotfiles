return {
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs_staged_enable = false,
		},
	},
}
