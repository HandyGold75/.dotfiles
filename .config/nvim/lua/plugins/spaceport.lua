return {
	{
		"CWood-sdf/spaceport.nvim",
		name = "spaceport",
		lazy = false,
		dependencies = { { "nvim-telescope/telescope.nvim", name = "telescope" } },
		config = function()
			require("spaceport").setup({
				projectEntry = "NvimTreeOpen",
				sections = { "_global_remaps", "name", "remaps", "recents", "hacker_news" },
			})
		end,
		keys = {
			{ "<leader>sp", ":Spaceport<CR>", { "n" }, silent = true, desc = "[s]pace[p]ort" },
			{ "<leader>fd", ":lua require('telescope').extensions.spaceport.find()<CR>", { "n" }, silent = true, desc = "Telescope [f]ind spaceport [d]irectory" },
		},
	},
}
