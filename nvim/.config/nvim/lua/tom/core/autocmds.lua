vim.o.autoread = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.formatoptions:append("ro")
		vim.opt_local.comments = "b:-,b:*,b:+,b:•,n:>"
	end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	callback = function()
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
		if ok and stats and stats.size > 100 * 1024 then
			vim.opt_local.foldmethod = "indent"
			vim.opt_local.foldexpr = ""
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})
