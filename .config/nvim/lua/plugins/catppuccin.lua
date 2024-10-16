return { {
	"catppuccin/nvim",
	name = "catppuccin",
	opts = { flavour = "mocha" },
	priority = 1000,
	event = { "VeryLazy" },
	config = function() vim.cmd.colorscheme("catppuccin") end,
} }
