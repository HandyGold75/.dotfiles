return {
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		dependencies = { { "ms-jpq/coq_nvim", name = "coq" } },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lsp = require("lspconfig")
			local coq = require("coq")

			lsp.lua_ls.setup(coq.lsp_ensure_capabilities({
				settings = {
					Lua = {
						completion = { callSnippet = "Both", displayContext = 5, keywordSnippet = "Both" },
						diagnostics = { globals = { "vim" }, workspaceDelay = 1000 },
						format = { enable = false },
						telemetry = { enable = true },
					},
				},
			}))
			lsp.gopls.setup(coq.lsp_ensure_capabilities({ settings = { gopls = {
				usePlaceholders = true,
				analyses = { unusedvariable = true },
				staticcheck = true,
				gofumpt = true,
			} } }))
			lsp.jedi_language_server.setup({})
			lsp.bashls.setup(coq.lsp_ensure_capabilities({}))
			lsp.html.setup(coq.lsp_ensure_capabilities({}))
			lsp.cssls.setup(coq.lsp_ensure_capabilities({}))
			lsp.ts_ls.setup(coq.lsp_ensure_capabilities({}))
			lsp.gdscript.setup(coq.lsp_ensure_capabilities({}))
			lsp.marksman.setup(coq.lsp_ensure_capabilities({}))
			lsp.ltex.setup(coq.lsp_ensure_capabilities({ settings = {
				ltex = { language = "en-US" },
			} }))
			lsp.jsonls.setup(coq.lsp_ensure_capabilities({}))
			lsp.taplo.setup(coq.lsp_ensure_capabilities({}))
			lsp.yamlls.setup(coq.lsp_ensure_capabilities({}))
			lsp.lemminx.setup(coq.lsp_ensure_capabilities({}))
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { { "neovim/nvim-lspconfig", name = "lspconfig" } },
		opts = { automatic_installation = true, ensure_installed = {} },
	},
	{
		"williamboman/mason.nvim",
		name = "mason",
		build = {
			":MasonInstall stylua goimports gofumpt isort black beautysh prettierd prettier taplo xmlformatter",
			":MasonInstall pylint shellcheck htmlhint stylelint quick-lint-js markdownlint jsonlint yamllint",
			":MasonInstall gdtoolkit",
		},
		cmd = { "Mason" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { { "williamboman/mason-lspconfig.nvim", name = "mason-lspconfig" } },
		opts = { ui = { border = "rounded" }, pip = { upgrade_pip = true } },
	},
}
