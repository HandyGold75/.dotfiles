return {
	{
		"nvim-treesitter/nvim-treesitter",
		name = "nvim-treesitter",
		config = function()
			vim.opt.runtimepath:append(vim.fn.stdpath("cache") .. "/parsers")
			require("nvim-treesitter").setup({
				parser_install_dir = vim.fn.stdpath("cache") .. "/parsers",
				ensure_installed = "all",
				auto_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}
