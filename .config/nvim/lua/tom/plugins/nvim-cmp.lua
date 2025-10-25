return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- buffer source
		"hrsh7th/cmp-path", -- path source
		"onsails/lspkind.nvim", -- icons
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			preselect = cmp.PreselectMode.Item,
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					-- disabe snippet options
					entry_filter = function(entry)
						return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Snippet
					end,
				},
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				format = function(entry, vim_item)
					local lspkind_ok, lspkind = pcall(require, "lspkind")
					if lspkind_ok then
						vim_item = lspkind.cmp_format({
							maxwidth = 50,
							ellipsis_char = "...",
						})(entry, vim_item)
					end

					local colorizer = require("tailwindcss-colorizer-cmp")
					vim_item = colorizer.formatter(entry, vim_item)

					return vim_item
				end,
			},
		})
	end,
}
