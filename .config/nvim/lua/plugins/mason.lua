return {
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		lazy = true,
		dependencies = { { "ms-jpq/coq_nvim", name = "coq" } },
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
		"mason-org/mason.nvim",
		name = "mason",
		lazy = true,
		dependencies = { { "neovim/nvim-lspconfig", name = "lspconfig" } },
		config = function()
			require("mason").setup({ ui = { border = "rounded" }, pip = { upgrade_pip = true } })
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall lua-language-server gopls jedi-language-server bash-language-server html-lsp css-lsp typescript-language-server gdtoolkit marksman ltex-ls json-lsp taplo yaml-language-server lemminx")
				vim.cmd("MasonInstall stylua goimports gofumpt isort black beautysh prettierd prettier taplo xmlformatter")
				vim.cmd("MasonInstall golangci-lint pylint shellcheck htmlhint stylelint quick-lint-js markdownlint jsonlint yamllint")
			end, {})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		cmd = { "Mason", "LspInfo", "LspStart", "LspStop", "LspRestart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { { "mason-org/mason.nvim", name = "mason" }, { "neovim/nvim-lspconfig", name = "lspconfig" } },
		opts = { automatic_installation = true, automatic_enable = false, ensure_installed = {} },
		keys = {
			{ "<leader>li", ":LspInfo<CR>", { "n" }, desc = "[l]sp [i]nfo" },
			{ "<leader>ls", ":LspStart<CR>", { "n" }, desc = "[l]sp [s]tart" },
			{ "<leader>lS", ":LspStop<CR>", { "n" }, desc = "[l]sp [S]top" },
			{ "<leader>lr", ":LspRestart<CR>", { "n" }, desc = "[l]sp [r]estart" },
		},
	},
}
