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
		version = "*",
		lazy = false,
		opts = function()
			return {
				keymap = {
					preset = "none",
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<CR>"] = { "accept", "fallback" },
					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<C-e>"] = { "hide", "fallback" },
				},

				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
				},

				completion = {
					list = {
						selection = {
							preselect = true,
							auto_insert = false,
						},
					},
					menu = {
						border = "rounded",
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
						draw = {
							columns = {
								{ "kind_icon", "label", gap = 1 },
								{ "kind" },
							},
						},
					},
					documentation = {
						auto_show = true,
						window = { border = "rounded" },
						update_delay_ms = 100,
					},
				},

				sources = {
					default = { "lsp", "lazydev", "path", "buffer" },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
						lsp = {
							transform_items = function(_, items)
								return vim.tbl_filter(function(item)
									return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
								end, items)
							end,
						},
					},
				},
			}
		end,
	},
}
