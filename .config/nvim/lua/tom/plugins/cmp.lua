return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim", -- 加這個即可
		},
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		opts = function()
			local lspkind = require("lspkind")
			lspkind.init({ preset = "codicons" }) -- 啟用 VSCode icon

			return {
				keymap = {
					preset = "default",
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<CR>"] = { "select_and_accept", "fallback" },
					["<C-u>"] = { "scroll_documentation_up", "fallback" },
					["<C-d>"] = { "scroll_documentation_down", "fallback" },
				},
				appearance = { nerd_font_variant = "mono" },
				completion = {
					documentation = { auto_show = true, window = { border = "rounded" } },
					list = { selection = { preselect = true } },
					menu = {
						border = "rounded",
						draw = {
							columns = {
								{ "kind_icon", "label", "label_description", "kind", gap = 1 },
							},
							components = {
								kind_icon = {
									text = function(ctx)
										return lspkind.symbol_map[ctx.kind] or ""
									end,
									highlight = "CmpItemKind",
								},
								label_description = { width = { max = 50 } },
								source_name = {
									text = function(ctx)
										return "[" .. ctx.source_name .. "]"
									end,
								},
							},
						},
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
					},
				},
			}
		end,
		opts_extend = { "sources.default" },
	},
}
