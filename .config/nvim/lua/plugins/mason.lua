return {
	{
		"williamboman/mason.nvim",
		name = "mason",
		cmd = "Mason",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { { "williamboman/mason-lspconfig.nvim", name = "mason-lspconfig" } },
		config = function()
			require("mason").setup({
				ui = { border = "rounded" },
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { { "neovim/nvim-lspconfig", name = "lspconfig" } },
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {},
			})
		end,
	},
}
