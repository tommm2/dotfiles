return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- Let lspconfig.lua be the single source of truth for enabling servers
      -- (with blink.cmp capabilities). Without this, mason-lspconfig v2
      -- auto-enables every installed server at startup with default config,
      -- which then gets re-enabled/re-configured by lspconfig.lua on BufReadPost
      -- and restarts the client (e.g. tsserver SIGTERM) -> intermittent no-LSP.
      automatic_enable = false,
      -- list of servers for mason to install
      ensure_installed = {
        "vtsls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "prismals",
        "pyright",
        "gopls",
        "ruff",
        "oxlint",
      },
    })
  end,
}
