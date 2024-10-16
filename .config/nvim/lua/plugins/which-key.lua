return { {
	"folke/which-key.nvim",
	opts = {
		preset = "helix",
	},
	event = "VeryLazy",
	keys = {
		{ "<leader>?", ":lua require('which-key').show()<CR>", { "n" }, silent = true, desc = "Show Which-Key[?]" },
	},
} }
