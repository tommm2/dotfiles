return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
			ts_ls = { cmd = { "typescript-language-server", "--stdio" } },
			cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
			pyright = { cmd = { "pyright-langserver", "--stdio" } },
			gopls = { cmd = { "gopls" } },
			ruff = { cmd = { "ruff", "server" } },
			eslint = { cmd = { "vscode-eslint-language-server", "--stdio" } },
			marksman = { cmd = { "marksman", "server" } },
			sqls = { cmd = { "sqls" } },
			yamlls = { cmd = { "yaml-language-server", "--stdio" } },
			jsonls = { cmd = { "vscode-json-language-server", "--stdio" } },
			lua_ls = {
				cmd = { "lua-language-server" },
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
							},
						},
					},
				},
			},
			dockerls = {
				cmd = { "docker-langserver", "--stdio" },
				filetypes = { "dockerfile" },
			},
			docker_compose_language_service = {
				cmd = { "docker-compose-langserver", "--stdio" },
				filetypes = { "yaml", "yml" },
				root_dir = function(fname)
					return vim.fs.root(fname, { "docker-compose.yml", "docker-compose.yaml", ".git" })
				end,
			},
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
