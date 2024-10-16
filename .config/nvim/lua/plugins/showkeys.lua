return {
	{
		"nvchad/showkeys",
		name = "showkeys",
		dependencies = { "nvchad/volt" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local showkeys = require("showkeys")
			showkeys.setup({
				timeout = 2,
				maxkeys = 5,
				show_count = true,
			})
			showkeys.toggle()
		end,
		keys = {
			{ "<leader>tk", ":lua require('showkeys').toggle()", { "n" }, silent = true, desc = "Showkeys [t]oggle [k]eys" },
		},
	},
}
