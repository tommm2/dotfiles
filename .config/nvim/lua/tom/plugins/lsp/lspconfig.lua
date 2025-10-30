return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	opts = {
		servers = {
			ts_ls = {
				settings = {
					inlayHints = { includeInlayParameterNameHints = "all" },
				},
			},
			cssls = {},
			pyright = {},
			gopls = {},
			ruff = {},
			eslint = {},
			marksman = {},
			sqls = {},
			yamlls = {},
			jsonls = {},
			lua_ls = {},
			dockerls = {},
			docker_compose_language_service = {},
		},
	},
	config = function(_, opts)
		local keymap = vim.keymap

		local function on_attach(client, bufnr)
			if client.server_capabilities.documentHighlightProvider then
				client.server_capabilities.documentHighlightProvider = false
			end

			local km_opts = { buffer = bufnr, silent = true, noremap = true }
			keymap.set("n", "gd", vim.lsp.buf.definition, km_opts)
			keymap.set("n", "gh", vim.lsp.buf.hover, km_opts)
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, km_opts)
			keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, km_opts)
			keymap.set("n", "[d", vim.diagnostic.goto_prev, km_opts)
			keymap.set("n", "]d", vim.diagnostic.goto_next, km_opts)
		end

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			config.on_attach = on_attach
			vim.lsp.config[server] = config
			vim.lsp.enable(server)
		end

		local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})
	end,
}
