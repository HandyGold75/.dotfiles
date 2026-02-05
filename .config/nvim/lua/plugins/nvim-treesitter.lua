return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter",
				-- ensure_installed = "all",
				auto_install = false,
				highlight = { enable = true, additional_vim_regex_highlighting = false, disable = { "gomod" } },
				indent = { enable = true },
			})

			vim.api.nvim_create_user_command("TSInstallAll", function() vim.cmd("TSInstall all") end, {})
		end,
	},
}
