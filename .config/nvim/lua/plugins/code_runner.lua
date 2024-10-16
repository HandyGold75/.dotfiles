return {
	{
		"CRAG666/code_runner.nvim",
		name = "code_runner",
		dependencies = { { "CRAG666/betterTerm.nvim", name = "betterTerm" } },
		config = function()
			require("code_runner").setup({
				mode = "better_term",
				better_term = {
					clean = true,
					number = 1,
				},
				filetype = {
					python = "python3 -u",
					go = "go run .",
				},
			})
		end,
		keys = {
			{
				"<leader>r",
				":wa<CR>" .. ":lua require('betterTerm').send(require('code_runner.commands').get_filetype_command(), 1, { clean = true, interrupt = true } )<CR>" .. ":lua require('betterTerm').open(1)<CR>",
				{ "n" },
				silent = true,
				desc = "Code Runner [r]un",
			},
		},
	},
}
