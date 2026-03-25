return {
	"renerocksai/telekasten.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		local home = vim.fn.expand("~/Desktop/note")
		local templates = vim.fn.expand("~/Desktop/note/templates")

		require("telekasten").setup({
			home = home,
			template_new_note = templates .. "/idea.md",
		})

		local function new_note_with_template()
			local choices = { "idea", "issue", "learning" }
			vim.ui.select(choices, { prompt = "Select template:" }, function(choice)
				if not choice then return end
				local dest = home .. "/issues/untitled.md"
				local template_file = templates .. "/" .. choice .. ".md"
				local date = os.date("%Y-%m-%d")
				local f = io.open(template_file, "r")
				local content = f:read("*a")
				f:close()
				content = content:gsub("date:", "date: " .. date)
				local out = io.open(dest, "w")
				out:write(content)
				out:close()
				vim.cmd("edit " .. dest)
			end)
		end

		vim.keymap.set("n", "<leader>nn", new_note_with_template, { desc = "New note with template" })
		vim.keymap.set("n", "<leader>nf", "<cmd>Telekasten find_notes<cr>", { desc = "Find notes" })
		vim.keymap.set("n", "<leader>ng", "<cmd>Telekasten search_notes<cr>", { desc = "Search notes" })
	end,
}
