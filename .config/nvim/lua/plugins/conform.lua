return {
	{
		"stevearc/conform.nvim",
		name = "conform",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				notify_on_error = true,
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},

				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports" },
					python = { "isort", "black" },

					sh = { "beautysh" },
					bash = { "beautysh" },

					html = { { "prettierd", "prettier" } },
					css = { { "prettierd", "prettier" } },
					javascript = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },

					gdscript = { "gdformat" },

					markdown = { { "prettierd", "prettier" } },
					json = { { "prettierd", "prettier" } },
					jsonc = { { "prettierd", "prettier" } },

					toml = { "taplo" },
					yaml = { { "prettierd", "prettier" } },
					xml = { "xmlformat" },
					["_"] = { "trim_whitespace", "trim_newlines" },
				},

				formatters = {
					stylua = { args = { "--verify", "--column-width", "256", "--collapse-simple-statement", "Always", "--search-parent-directories", "--stdin-filepath", "$FILENAME", "-" } },
					isort = { args = { "--profile", "black", "--combine-as", "--line-length", "256", "--stdout", "--filename", "$FILENAME", "-" } },
					black = { args = { "--line-length", "256", "--stdin-filename", "$FILENAME", "--quiet", "-" } },
					gdscript = { args = { "--line-length=256", "$FILENAME", "-" } },
				},
			})
		end,
	},
}
