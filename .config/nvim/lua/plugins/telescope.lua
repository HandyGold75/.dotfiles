return {
	{
		"nvim-telescope/telescope.nvim",
		name = "telescope",
		dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep", { "CWood-sdf/spaceport.nvim", name = "spaceport" }, { "rcarriga/nvim-notify", name = "notify" } },
		keys = {
			{ "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", { "n" }, silent = true, desc = "Telescope [f]ind [files]" },
			{ "<leader>fF", ":lua require('telescope.builtin').find_files( { hidden = true, no_ignore = true, no_ignore_parent = true } )<CR>", { "n" }, silent = true, desc = "Telescope [f]ind hidden [f]iles" },
			{ "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", { "n" }, silent = true, desc = "Telescope [f]ind with [g]rep" },
			{ "<leader>fG", ":lua require('telescope.builtin').live_grep( { additional_args = {'--hidden'} } )<CR>", { "n" }, silent = true, desc = "Telescope [f]ind hidden with [G]rep" },
			{ "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", { "n" }, silent = true, desc = "Telescope [f]ind [b]uffer" },
			{ "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", { "n" }, silent = true, desc = "Telescope [f]ind [h]elp" },
			{ "<leader>fd", ":lua require('telescope').extensions.spaceport.find()<CR>", { "n" }, silent = true, desc = "Telescope [f]ind spaceport [d]irectory" },
			{ "<leader>fn", ":lua require('telescope').extensions.notify.notify()<CR>", { "n" }, silent = true, desc = "Telescope [f]ind [n]otify" },
		},
	},
}
