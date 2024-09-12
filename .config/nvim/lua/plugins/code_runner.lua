return {
	{
		"CRAG666/code_runner.nvim",
		name = "code_runner",
		config = function()
			require("code_runner").setup({
				mode = "better_term",
				filetype = {
					python = "python3 -u",
					go = "cd $dir && go run .",
				},
			})
		end,
		keys = {
			{ "<leader>rr", ":RunCode<CR>", mode = { "n" } },
			{ "<leader>rf", ":RunFile<CR>", mode = { "n" } },
			-- { "<leader>rft", ":RunFile tab<CR>", mode = { "n" } },
			{ "<leader>rp", ":RunProject<CR>", mode = { "n" } },
			{ "<leader>rc", ":RunClose<CR>", mode = { "n" } },
			-- { "<leader>crf", ":CRFiletype<CR>", mode = { "n" } },
			-- { "<leader>crp", ":CRProjects<CR>", mode = { "n" } },
		},
	},
}
