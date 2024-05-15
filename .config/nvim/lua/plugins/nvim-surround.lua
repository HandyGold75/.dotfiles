return { {
	"kylechui/nvim-surround",
	name = "nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	config = function() require("nvim-surround").setup() end,
} }
