vim.o.autoread = true

-- Note templates
local templates = {
	["*/note/bugs/*.md"] = "bug.md",
	["*/note/ideas/*.md"] = "idea.md",
	["*/note/docs/*.md"] = "doc.md",
}

for pattern, template in pairs(templates) do
	vim.api.nvim_create_autocmd("BufNewFile", {
		pattern = pattern,
		callback = function()
			vim.cmd("0r /Users/jinzhengrong/Desktop/note/templates/" .. template)
			local date = os.date("%Y-%m-%d")
			vim.cmd("silent! %s/^date:$/date: " .. date .. "/")
		end,
	})
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})
