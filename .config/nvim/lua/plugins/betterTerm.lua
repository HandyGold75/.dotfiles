return {
	{
		"CRAG666/betterTerm.nvim",
		name = "betterTerm",
		dependencies = { { "CRAG666/code_runner.nvim", name = "code_runner" } },
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
			{ "<C-o>", ":lua require('betterTerm').open()<CR>", mode = { "n", "t" } },
			{ "<leader>tt", ":lua require('betterTerm').select()<CR>", mode = { "n" } },
			{ "<leader>e", ":lua vim.cmd('wa') require('betterTerm').send(require('code_runner.commands').get_filetype_command(), 1, { clean = true, interrupt = true } )<CR>", mode = { "n" } },
		},
	},
}
