return {
	{
		"CWood-sdf/spaceport.nvim",
		name = "spaceport",
		lazy = false,
		config = function()
			require("spaceport").setup({
				projectEntry = "NvimTreeOpen",
				sections = { "_global_remaps", "name", "remaps", "recents" },
				-- sections = { "_global_remaps", "name", "remaps", "recents", "hacker_news" },
			})
		end,
		keys = {
			{ "<leader>sp", ":Spaceport<CR>", { "n" }, desc = "[s]pace[p]ort" },
		},
	},
}
