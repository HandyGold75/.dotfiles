return { {
	"MeanderingProgrammer/render-markdown.nvim",
	name = "render-markdown",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
} }
