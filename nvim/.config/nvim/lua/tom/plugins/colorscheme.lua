return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main",
				dark_variant = "main",
				styles = {
					bold = false,
					italic = false,
					transparency = true,
				},
				palette = {
					main = {
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
						highlight_low = "#21202e",
						highlight_med = "#403d52",
						highlight_high = "#524f67",
					},
				},
				highlight_groups = {
					StatusLine = { fg = "iris", bg = "none" },
					StatusLineNC = { fg = "muted", bg = "none" },
					TelescopeBorder = { fg = "iris", bg = "none" },
					TelescopeNormal = { bg = "none" },
					TelescopePromptNormal = { bg = "none" },
					TelescopeResultsNormal = { bg = "none" },
					TelescopePreviewNormal = { bg = "none" },
					NormalFloat = { bg = "none" },
					FloatBorder = { fg = "iris", bg = "none" },
					Pmenu = { bg = "overlay" },
					CursorLine = { bg = "highlight_low" },
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
