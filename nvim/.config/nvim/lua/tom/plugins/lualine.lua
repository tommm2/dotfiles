return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				-- section_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				component_separators = "",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						-- separator = { right = "" },
						separator = { right = "" },
						color = function()
							if vim.bo.modified then
								return { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" }
							else
								return { fg = "#cdd6f4", bg = "#3c3e52" }
							end
						end,
						symbols = {
							modified = " ●",
							readonly = "",
							unnamed = "[No Name]",
						},
					},
				},
			},
		})
	end,
}
