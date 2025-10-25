-- update untracked file, path hidden file color
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("SnacksHighlightOverrides", { clear = true }),
	callback = function()
		vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#a6e3a1" }) -- 綠色
		vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#cbd6f7" })
	end,
})
