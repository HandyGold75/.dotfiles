return {
	{
		"rcarriga/nvim-notify",
		name = "notify",
		lazy = false,
		dependencies = { { "nvim-telescope/telescope.nvim", name = "telescope" } },
		config = function() vim.notify = require("notify") end,
		keys = {
			{ "<leader>fn", ":lua require('telescope').extensions.notify.notify()<CR>", mode = { "n" } },
		},
	},
}
