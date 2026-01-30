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
					javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
					typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
				},
			},
			cssls = {},
			tailwindcss = {},
			gopls = {},
			ruff = {},
			eslint = {},
			marksman = {},
			sqls = {},
			yamlls = {},
			jsonls = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			},
			dockerls = {},
			docker_compose_language_service = {},
		},
	},
	config = function(_, opts)
		-- Get base capabilities from blink.cmp
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Extend server options with capabilities
		for _, server_opts in pairs(opts.servers) do
			server_opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
		end

		-- Diagnostic signs and configuration
		local signs = { Error = "", Warn = "", Info = "", Hint = "󰌶" }
		vim.diagnostic.config({
			virtual_text = { prefix = "●" },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.INFO] = signs.Info,
					[vim.diagnostic.severity.HINT] = signs.Hint,
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = { border = "rounded" },
		})

		vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#f38ba8" })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#f9e2af" })

		-- LSP Attach Autocommand for keymaps and settings
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local bufnr = ev.buf
				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				-- Disable document highlighting to improve performance
				if client and client.server_capabilities.documentHighlightProvider then
					client.server_capabilities.documentHighlightProvider = false
				end

				local function nmap(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true, desc = "LSP: " .. desc })
				end

				nmap("gd", vim.lsp.buf.definition, "Go to Definition")
				nmap("gh", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, "Hover Documentation")
				nmap("gl", function()
					vim.diagnostic.open_float({ border = "rounded" })
				end, "Show Diagnostic")
				nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
				nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				nmap("[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, "Previous Diagnostic")
				nmap("]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, "Next Diagnostic")

				if client and client.server_capabilities.inlayHintProvider then
					nmap("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
					end, "Toggle Inlay Hints")
				end
			end,
		})
	end,
}
