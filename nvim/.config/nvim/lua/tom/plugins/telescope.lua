return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
		{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find string" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Find jumplist" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_strategy = "flex",
				preview = {
					mime_hook = function(filepath, bufnr, opts)
						local is_image = function(filepath)
							local image_extensions = { "png", "jpg" } -- Supported image formats
							local split_path = vim.split(filepath:lower(), ".", { plain = true })
							local extension = split_path[#split_path]
							return vim.tbl_contains(image_extensions, extension)
						end
						if is_image(filepath) then
							local term = vim.api.nvim_open_term(bufnr, {})
							local function send_output(_, data, _)
								for _, d in ipairs(data) do
									vim.api.nvim_chan_send(term, d .. "\r\n")
								end
							end
							vim.fn.jobstart({
								"catimg",
								filepath, -- Terminal image viewer command
							}, { on_stdout = send_output, stdout_buffered = true, pty = true })
						else
							require("telescope.previewers.utils").set_preview_message(
								bufnr,
								opts.winid,
								"Binary cannot be previewed"
							)
						end
					end,
				},
				layout_config = {
					horizontal = {
						preview_width = 0.6,
					},
					vertical = {
						preview_height = 0.6,
					},
					flex = {
						flip_columns = 120,
					},
				},
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = false,
				},
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
		keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Find jumplist" })
		local note_home = vim.fn.expand("~/Desktop/note")
		keymap.set("n", "<leader>nf", function()
			require("telescope.builtin").find_files({ cwd = note_home, prompt_title = "Find Notes" })
		end, { desc = "Find notes" })
		keymap.set("n", "<leader>ng", function()
			require("telescope.builtin").live_grep({ cwd = note_home, prompt_title = "Search Notes" })
		end, { desc = "Search notes" })
		keymap.set("n", "<leader>nn", function()
			local choices = { "idea", "issue", "learning" }
			vim.ui.select(choices, { prompt = "Select template:" }, function(choice)
				if not choice then return end
				local dest = note_home .. "/issues/untitled.md"
				local template_file = note_home .. "/templates/" .. choice .. ".md"
				local date = os.date("%Y-%m-%d")
				local f = io.open(template_file, "r")
				if not f then return end
				local content = f:read("*a")
				f:close()
				content = content:gsub("date:", "date: " .. date)
				local out = io.open(dest, "w")
				if not out then return end
				out:write(content)
				out:close()
				vim.cmd("edit " .. dest)
			end)
		end, { desc = "New note with template" })
		keymap.set("n", "<leader>fh", function()
			require("telescope.builtin").find_files({
				find_command = { "fd", "--hidden", "--no-ignore", "--glob", ".env*" },
				prompt_title = "Find .env files",
			})
		end, { desc = "Find .env files" })
		keymap.set("n", "<leader>fd", function()
			require("telescope.builtin").find_files({
				find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
				prompt_title = "Find Directory",
				attach_mappings = function(_, map)
					map("i", "<CR>", function(bufnr)
						local selection = require("telescope.actions.state").get_selected_entry()
						require("telescope.actions").close(bufnr)
						require("oil").open(selection[1])
					end)
					return true
				end,
			})
		end, { desc = "Find directory (open in Oil)" })
	end,
}
