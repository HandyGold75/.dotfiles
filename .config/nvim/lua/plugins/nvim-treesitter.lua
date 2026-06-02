return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		-- event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup({ install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "<filetype>" },
				callback = function()
					-- Highlighting
					vim.treesitter.start()

					-- Folds
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"

					-- Indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
			vim.api.nvim_create_user_command("TSInstallAll", function() vim.cmd("TSInstall all") end, {})
		end,
	},
}
