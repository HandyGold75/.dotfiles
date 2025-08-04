return {
	{
		"CRAG666/betterTerm.nvim",
		name = "betterTerm",
		config = function()
			require("betterTerm").setup({ size = 15 })
			vim.keymap.set({ "n", "t" }, "<C-->", require("betterTerm").open)
			vim.keymap.set({ "t" }, "<leader>o", require("betterTerm").select)
			vim.keymap.set({ "t" }, "<leader>q", "<ESC><C-\\><C-n>:bd!<CR>")
		end,
		keys = {
			{ "<C-->", function() require("betterTerm").open() end, { "n", "t" }, desc = "BetterTerm toggle terminal" },
			{ "<leader>-", function() require("betterTerm").select() end, { "t" }, desc = "BetterTerm select terminal" },
			{ "<leader>q", "<ESC><C-\\><C-n>:bd!<CR>", { "t" }, desc = "BetterTerm quit terminal" },
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
