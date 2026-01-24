return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
			{ "<leader>td", "<cmd>TermExec cmd='npm run dev'<cr>", desc = "npm run dev" },
			{ "<leader>tt", "<cmd>TermExec cmd='npm test'<cr>", desc = "npm test" },
			{ "<leader>tb", "<cmd>TermExec cmd='npm run build'<cr>", desc = "npm run build" },
		},
		opts = {
			size = 15,
			direction = "horizontal",
		},
	},
}
