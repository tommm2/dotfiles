return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		explorer = {
			enabled = true,
		},
		picker = {
			grep = {
				hidden = true,
				ignored = true,
			},
			sources = {
				files = {
					exclude = { "node_modules", ".next", "dist", "build" },
					hidden = true,
					ignored = true,
				},
				explorer = {
					hidden = true,
					ignored = true,
				},
			},
		},
		indent = { enabled = true, animate = { enabled = false } },
		input = {},
		image = {},
		quickfile = { enabled = true },
		scope = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		-- explorer
		{
			"<leader>ee",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},

		-- picker
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files in cwd",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "list buffer",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Find recent files",
		},
		{
			"<leader>fw",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live grep in cwd",
		},
		{
			"<leader>jl",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Show jump list",
		},

		-- lazygit
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Open lazygit",
		},
		{
			"<leader>gr",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Open lazygit reflog",
		},

		-- lsp
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},

		-- buffer delete
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Buffer delete",
		},
		{
			"<leader>bD",
			function()
				Snacks.bufdelete.all()
			end,
			desc = "Buffer delete",
		},
	},
}
