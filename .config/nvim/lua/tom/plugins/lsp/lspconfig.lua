return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local keymap = vim.keymap

		local function on_attach(client, bufnr)
			-- remove highlight when cursor on variable
			if client.server_capabilities.documentHighlightProvider then
				client.server_capabilities.documentHighlightProvider = false
			end

			local opts = { buffer = bufnr, silent = true, noremap = true }
			keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			keymap.set("n", "gh", vim.lsp.buf.hover, opts)
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		end

		local servers = {
			ts_ls = {},
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
		}

		for name, conf in pairs(servers) do
			conf.capabilities = capabilities
			conf.on_attach = on_attach
			vim.lsp.config[name] = conf
			vim.lsp.enable(name)
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
