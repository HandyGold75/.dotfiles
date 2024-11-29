return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSInstall all",
		event = { "BufReadPre", "BufNewFile" },
		main = "nvim-treesitter.configs",
		opts = {
			parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter",
			ensure_installed = "all",
			auto_install = false,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
		},
	},
}
