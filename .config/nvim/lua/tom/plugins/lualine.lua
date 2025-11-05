return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
				component_separators = "",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						separator = { right = "" },
						color = function()
							if vim.bo.modified then
								return { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" }
							else
								return { fg = "#cdd6f4", bg = "#3c3e52" }
							end
						end,
						symbols = {
							modified = " ●", -- 只有未儲存才會出現
							readonly = "",
							unnamed = "[No Name]",
						},
					},
				},
			},
		})
	end,
}
