return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local colors = {
			base = "#191724",
			surface = "#1f1d2e",
			overlay = "#26233a",
			muted = "#6e6a86",
			subtle = "#908caa",
			text = "#e0def4",
			love = "#eb6f92",
			gold = "#f6c177",
			rose = "#ebbcba",
			pine = "#31748f",
			foam = "#9ccfd8",
			iris = "#c4a7e7",
		}

		lualine.setup({
			options = {
				theme = "rose-pine",
				section_separators = { left = "", right = "" },
				component_separators = "",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						separator = { right = "" },
						color = function()
							if vim.bo.modified then
								return { fg = colors.base, bg = colors.gold, gui = "bold" }
							else
								return { fg = colors.text, bg = colors.overlay }
							end
						end,
						symbols = {
							modified = " ●",
							readonly = "",
							unnamed = "[No Name]",
					},
          },
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = {},
				lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
			},
		})
	end,
}
