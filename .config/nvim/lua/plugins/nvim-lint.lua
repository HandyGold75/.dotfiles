return {
	{
		"mfussenegger/nvim-lint",
		name = "nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "pylint" },

				sh = { "shellcheck" },
				bash = { "shellcheck" },

				html = { "htmlhint" },
				-- css = { "stylelint" },
				javascript = { "quick-lint-js" },
				typescript = { "quick-lint-js" },

				gdscript = { "gdlint" },

				markdown = { "markdownlint" },
				json = { "jsonlint" },
				jsonc = { "jsonlint" },
				yaml = { "yamllint" },
			}

			lint.linters.pylint.args = { "--max-line-length", "256", "--variable-naming-style", "camelCase", "-f", "json" }

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			local linting = true
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					if linting == true then lint.try_lint() end
				end,
			})

			local toggle_lint = function()
				if linting == true then
					linting = false
					vim.diagnostic.reset(nil, 0)
				else
					linting = true
					lint.try_lint()
				end
			end
			vim.keymap.set({ "n" }, "<leader>tl", toggle_lint, { noremap = true, desc = "Lint [t]oggle [l]int" })
		end,
		keys = {
			{ "<leader>tl", ":lua require('lint').try_lint()<CR>", { "n" }, silent = true, desc = "Lint [t]oggle [l]int" },
		},
	},
}
