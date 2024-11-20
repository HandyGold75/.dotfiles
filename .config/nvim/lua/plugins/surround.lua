return { {
	"kylechui/nvim-surround",
	name = "surround",
	event = { "BufReadPre", "BufNewFile" },
	config = function() require("nvim-surround").setup() end,
} }
