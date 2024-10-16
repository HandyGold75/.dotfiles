return {
	{
		"rcarriga/nvim-notify",
		name = "notify",
		lazy = false,
		dependencies = { { "nvim-telescope/telescope.nvim", name = "telescope" } },
		config = function() vim.notify = require("notify") end,
		keys = {
			{ "<leader>fn", ":lua require('telescope').extensions.notify.notify()<CR>", { "n" }, silent = true, desc = "Telescope [f]ind [n]otify" },
		},
	},
}
