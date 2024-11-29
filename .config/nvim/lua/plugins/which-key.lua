return { {
	"folke/which-key.nvim",
	name = "which-key",
	opts = { preset = "helix" },
	event = { "VeryLazy" },
	keys = {
		{ "<leader>?", function() require("which-key").show() end, { "n" }, silent = true, desc = "Show Which-Key[?]" },
	},
} }
