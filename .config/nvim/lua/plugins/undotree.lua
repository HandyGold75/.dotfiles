return { {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	config = true,
	keys = {
		{ "<leader>u", ":lua require('undotree').toggle()<CR>", { "n" }, desc = "Toggle [u]ndo tree" },
	},
} }
