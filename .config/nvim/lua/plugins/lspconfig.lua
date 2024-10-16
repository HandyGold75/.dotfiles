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
						completion = {
							callSnippet = "Both",
							displayContext = 5,
							keywordSnippet = "Both",
						},
						diagnostics = {
							globals = { "vim" },
							workspaceDelay = 1000,
						},
						format = { enable = false },
						telemetry = { enable = true },
					},
				},
			}))
			lsp.gopls.setup(coq.lsp_ensure_capabilities({
				settings = {
					usePlaceholders = true,
					analyses = { unusedvariable = true },
				},
			}))
			lsp.jedi_language_server.setup({})

			lsp.bashls.setup(coq.lsp_ensure_capabilities({}))

			lsp.html.setup(coq.lsp_ensure_capabilities({}))
			lsp.cssls.setup(coq.lsp_ensure_capabilities({}))
			lsp.ts_ls.setup(coq.lsp_ensure_capabilities({}))

			lsp.gdscript.setup(coq.lsp_ensure_capabilities({}))

			lsp.marksman.setup(coq.lsp_ensure_capabilities({}))

			lsp.ltex.setup(coq.lsp_ensure_capabilities({
				settings = {
					ltex = {
						language = "en-US",
					},
				},
			}))

			lsp.jsonls.setup(coq.lsp_ensure_capabilities({}))
			lsp.taplo.setup(coq.lsp_ensure_capabilities({}))
			lsp.yamlls.setup(coq.lsp_ensure_capabilities({}))
			lsp.lemminx.setup(coq.lsp_ensure_capabilities({}))
		end,
	},
}
