return {
	{
		"mfussenegger/nvim-lint",
		name = "lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				go = { "golangcilint" },
				python = { "pylint" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				html = { "htmlhint" },
				css = { "stylelint" },
				javascript = { "quick-lint-js" },
				typescript = { "quick-lint-js" },
				gdscript = { "gdlint" },
				markdown = { "markdownlint" },
				json = { "jsonlint" },
				jsonc = { "jsonlint" },
				yaml = { "yamllint" },
			}

			lint.linters.pylint.args = { "--max-line-length", "256", "--variable-naming-style", "camelCase", "-f", "json" }

			local linting = true
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("lint", { clear = true }),
				callback = function()
					if linting then lint.try_lint() end
				end,
			})
			local toggle_lint = function()
				linting = not linting
				if linting then
					lint.try_lint()
				else
					vim.diagnostic.reset(nil, 0)
				end
			end
			vim.keymap.set({ "n" }, "<leader>tl", toggle_lint, { noremap = true, desc = "Lint [t]oggle [l]int" })
		end,
	},
}
