return {
	{
		"CRAG666/betterTerm.nvim",
		name = "betterTerm",
		config = function()
			require("betterTerm").setup({
				size = 25,
			})

			local current = 1
			vim.keymap.set("n", "<leader>tn", function()
				current = current + 1
				require("betterTerm").open(current)
			end)

			vim.keymap.set({ "n", "t" }, "<C-o>", require("betterTerm").open)
		end,
		keys = {
			{ "<C-o>", ":lua require('betterTerm').open()<CR>", { "n", "t" }, silent = true, desc = "BetterTerm toggle terminal" },
			{ "<leader>st", ":lua require('betterTerm').select()<CR>", { "n" }, silent = true, desc = "BetterTerm [s]elect [t]erminal" },
			{ "<leader>sn", ":lua require('betterTerm').open(1)<CR>", { "n" }, silent = true, desc = "BetterTerm [s]elect [n]ew terminal" },
		},
	},
}
