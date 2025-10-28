return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			no_italic = true,
			styles = {
				comments = { "italic" },
			},
		})
		vim.cmd("colorscheme catppuccin-mocha")
	end,
}

-- return {
-- 	"olivercederborg/poimandres.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("poimandres").setup({
-- 			disable_background = true,
-- 			disable_italics = true,
-- 		})
-- 	end,
--
-- 	-- optionally set the colorscheme within lazy config
-- 	init = function()
-- 		vim.cmd("colorscheme poimandres")
-- 	end,
-- }
