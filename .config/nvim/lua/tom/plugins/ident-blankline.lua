return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "VeryLazy",
	opts = {
		indent = {
			char = "│",
			smart_indent_cap = true,
			highlight = { "IblIndent" },
		},
		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			highlight = { "IblScope" },
		},
		whitespace = { remove_blankline_trail = true },
	},
	config = function(_, opts)
		local ibl = require("ibl")

		local function set_indent_colors()
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#56597a" })
		end

		set_indent_colors()
		ibl.setup(opts)

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_indent_colors,
		})
	end,
}
