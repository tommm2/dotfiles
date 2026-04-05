return {
	"nvim-neotest/neotest",
	cmd = { "Neotest" },
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run file tests",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
		"nvim-neotest/neotest-python",
		"marilari88/neotest-vitest",
	},
	opts = function()
		return {
			adapters = {
				require("neotest-jest")({}),
				require("neotest-python")({
					args = { "-q" },
					is_test_file = function(file_path)
						if vim.endswith(file_path, ".py") == false then
							return false
						end
						local file_name = vim.fn.fnamemodify(file_path, ":t")
						return file_name:match("^test_.*%.py$") ~= nil or file_name:match("^.*_test%.py$") ~= nil
					end,
					pytest_discover_instances = true,
					runner = "pytest",
				}),
				require("neotest-vitest"),
			},
		}
	end,
}
