return {
	{
		"stevearc/conform.nvim",
		name = "conform",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				notify_on_error = true,
				notify_no_formatters = true,
				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
					return { timeout_ms = 2500, lsp_format = "fallback" }
				end,

				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports", "gofumpt" },
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

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, { desc = "Disable autoformat-on-save", bang = true })

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, { desc = "Re-enable autoformat-on-save" })
		end,
	},
}
