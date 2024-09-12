return {
	{
		"stevearc/conform.nvim",
		name = "conform",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				notify_on_error = true,
				notify_no_formatters = true,
				format_on_save = {
					timeout_ms = 1000,
					lsp_fallback = true,
				},

				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports" },
					python = { "isort", "black" },

					sh = { "beautysh" },
					bash = { "beautysh" },

					html = { "prettierd", "prettier", stop_after_first = true },
					css = { "prettierd", "prettier", stop_after_first = true },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },

					gdscript = { "gdformat" },

					markdown = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					jsonc = { "prettierd", "prettier", stop_after_first = true },

					toml = { "taplo" },
					yaml = { "prettierd", "prettier", stop_after_first = true },
					xml = { "xmlformat" },
					["_"] = { "trim_whitespace", "trim_newlines" },
				},

				formatters = {
					stylua = { args = { "--verify", "--column-width", "256", "--collapse-simple-statement", "Always", "--search-parent-directories", "--stdin-filepath", "$FILENAME", "-" } },
					isort = { args = { "--profile", "black", "--combine-as", "--line-length", "256", "--stdout", "--filename", "$FILENAME", "-" } },
					black = { args = { "--line-length", "256", "--stdin-filename", "$FILENAME", "--quiet", "-" } },
					gdformat = { args = { "-l", "256", "-" } },
				},
			})
		end,
	},
}
