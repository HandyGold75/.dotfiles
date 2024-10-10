return {
	{
		"nvchad/showkeys",
		name = "showkeys",
		dependencies = { "nvchad/volt" },
		config = function()
			local showkeys = require("showkeys")
			showkeys.setup({
				timeout = 2,
				maxkeys = 5,
				show_count = true,
			})
			showkeys.toggle()
			vim.keymap.set({ "n" }, "<leader>tk", showkeys.toggle, { noremap = true, desc = "Showkeys" })
		end,
	},
}
