return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		maximum_padding = 2,
		minimum_padding = 2,
		buffer_index = false,
		buffer_number = false,
		separator_at_end = false,
		animation = false,
	},
	version = "^1.0.0",
	config = function(_, opts)
		require("barbar").setup(opts)

		local colors = require("catppuccin.palettes").get_palette("mocha")

		vim.api.nvim_set_hl(0, "BufferCurrent", { bg = colors.base, fg = colors.text, bold = true })
		vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = colors.base, fg = colors.peach })
		vim.api.nvim_set_hl(0, "BufferCurrentSign", { bg = colors.base, fg = colors.lavender })
		vim.api.nvim_set_hl(0, "BufferVisible", { bg = colors.mantle, fg = colors.subtext1 })
		vim.api.nvim_set_hl(0, "BufferInactive", { bg = colors.crust, fg = colors.overlay0 })
		vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = colors.crust, fg = colors.peach })
		vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = colors.crust, fg = colors.surface2 })
		vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = colors.crust })
		vim.api.nvim_set_hl(0, "BufferOffset", { bg = colors.crust, fg = colors.overlay1 })
	end,
}
