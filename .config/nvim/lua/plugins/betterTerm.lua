return {
	{
		"CRAG666/betterTerm.nvim",
		name = "betterTerm",
		config = function()
			require("betterTerm").setup({ size = 15, new_tab_mapping = "<C-t>", jump_tab_mapping = "<C-k$tab>" })
			vim.keymap.set({ "n", "t" }, "<C-o>", require("betterTerm").toggle_termwindow, { noremap = true, desc = "BetterTerm toggle terminal window" })
			vim.keymap.set({ "t" }, "<C-=>", function() require("betterTerm").cycle(1) end, { noremap = true, desc = "BetterTerm next terminal tab" })
			vim.keymap.set({ "t" }, "<C-->", function() require("betterTerm").cycle(-1) end, { noremap = true, desc = "BetterTerm previous terminal tab" })
		end,
		keys = {
			{ "<C-o>", function() require("betterTerm").toggle_termwindow() end, { "n", "t" }, desc = "BetterTerm toggle terminal window" },
			{ "<C-=>", function() require("betterTerm").cycle(1) end, { "t" }, desc = "BetterTerm next terminal tab" },
			{ "<C-->", function() require("betterTerm").cycle(-1) end, { "t" }, desc = "BetterTerm previous terminal tab" },
		},
	},
	{
		"CRAG666/code_runner.nvim",
		name = "code_runner",
		dependencies = { { "CRAG666/betterTerm.nvim", name = "betterTerm" } },
		opts = {
			mode = "better_term",
			better_term = { clean = true, number = 1 },
			filetype = {
				python = "python3 -u $file",
				go = "go run .$end",
			},
		},
		keys = { { "<leader>r", function() require("betterTerm").send(require("code_runner.commands").get_filetype_command(), 1, { clean = true, interrupt = true }) end, { "n" }, desc = "Code Runner [r]un" } },
	},
}
