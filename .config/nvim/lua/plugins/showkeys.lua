return {
	{
		"nvchad/showkeys",
		name = "showkeys",
		dependencies = { "nvchad/volt" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("showkeys").setup({ timeout = 2, maxkeys = 5, show_count = true })
			require("showkeys").toggle()
		end,
		keys = { { "<leader>tk", function() require("showkeys").toggle() end, { "n" }, desc = "Showkeys [t]oggle [k]eys" } },
	},
}
