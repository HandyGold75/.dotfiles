return { {
	"catppuccin/nvim",
	name = "catppuccin",
	opts = { flavour = "mocha" },
	priority = 1000,
	config = function() vim.cmd.colorscheme("catppuccin") end,
} }
