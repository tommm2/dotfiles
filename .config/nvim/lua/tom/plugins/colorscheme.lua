return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			no_italic = true,
			gitsigns = true,
			barbar = true,
			styles = {
				comments = { "italic" },
			},
			neotree = {
				enabled = false,
				show_root = false,
				transparent_panel = false,
			},
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
			},
		})
		vim.cmd("colorscheme catppuccin-mocha")
	end,
}
