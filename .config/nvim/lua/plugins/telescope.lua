return {
	{
		"nvim-telescope/telescope.nvim",
		name = "telescope",
		dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
		keys = {
			{ "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", mode = { "n" } },
			{ "<leader>fF", ":lua require('telescope.builtin').find_files( { hidden = true, no_ignore = true, no_ignore_parent = true } )<CR>", mode = { "n" } },
			{ "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", mode = { "n" } },
			{ "<leader>fG", ":lua require('telescope.builtin').live_grep( { additional_args = {'--hidden'} } )<CR>", mode = { "n" } },
			{ "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", mode = { "n" } },
			{ "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", mode = { "n" } },
		},
	},
}
