return {
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		lazy = true,
		dependencies = { { "ms-jpq/coq_nvim", name = "coq" } },
		config = function()
			local coq = require("coq")

			vim.lsp.config("lua_ls", {
				coq.lsp_ensure_capabilities({
					settings = {
						Lua = {
							completion = { callSnippet = "Both", displayContext = 5, keywordSnippet = "Both" },
							diagnostics = { globals = { "vim" }, workspaceDelay = 1000 },
							format = { enable = false },
							telemetry = { enable = true },
						},
					},
				}),
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("gopls", { coq.lsp_ensure_capabilities({ settings = { gopls = {
				usePlaceholders = true,
				analyses = { unusedvariable = true },
				staticcheck = true,
				gofumpt = true,
			} } }) })
			vim.lsp.enable("gopls")

			vim.lsp.config("jedi_language_server", { {} })
			vim.lsp.enable("jedi_language_server")

			vim.lsp.config("bashls", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("bashls")

			vim.lsp.config("html", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("html")

			vim.lsp.config("cssls", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("cssls")

			vim.lsp.config("ts_ls", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("ts_ls")

			vim.lsp.config("gdscript", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("gdscript")

			vim.lsp.config("marksman", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("marksman")

			vim.lsp.config("ltex", { coq.lsp_ensure_capabilities({ settings = {
				ltex = { language = "en-US" },
			} }) })
			vim.lsp.enable("ltex")

			vim.lsp.config("jsonls", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("jsonls")

			vim.lsp.config("taplo", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("taplo")

			vim.lsp.config("yamlls", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("yamlls")

			vim.lsp.config("lemminx", { coq.lsp_ensure_capabilities({}) })
			vim.lsp.enable("lemminx")
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
