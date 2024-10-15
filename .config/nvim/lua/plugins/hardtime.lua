return {
	{
		"m4xshen/hardtime.nvim",
		name = "hardtime",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("hardtime").setup({
				disable_mouse = false,
				max_count = 6,
				disabled_filetypes = { "better_term" },
				disabled_keys = {
					["<Up>"] = { "n", "x" },
					["<Down>"] = { "n", "x" },
					["<Left>"] = { "n", "x" },
					["<Right>"] = { "n", "x" },
				},
			})
		end,
	},
}
