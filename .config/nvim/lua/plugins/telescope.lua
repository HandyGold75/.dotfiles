return {
	{
		"nvim-telescope/telescope.nvim",
		name = "telescope",
		dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep", { "CWood-sdf/spaceport.nvim", name = "spaceport" }, { "rcarriga/nvim-notify", name = "notify" } },
		cmd = { "Telescope" },
		keys = {
			{ "<leader>ff", function() require("telescope.builtin").find_files() end, { "n" }, desc = "Telescope [f]ind [files]" },
			{ "<leader>fF", function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true, no_ignore_parent = true }) end, { "n" }, desc = "Telescope [f]ind hidden [f]iles" },
			{ "<leader>fg", function() require("telescope.builtin").live_grep() end, { "n" }, desc = "Telescope [f]ind with [g]rep" },
			{ "<leader>fG", function() require("telescope.builtin").live_grep({ additional_args = { "--hidden" } }) end, { "n" }, desc = "Telescope [f]ind hidden with [G]rep" },
			{ "<leader>fb", function() require("telescope.builtin").buffers() end, { "n" }, desc = "Telescope [f]ind [b]uffer" },
			{ "<leader>fh", function() require("telescope.builtin").help_tags() end, { "n" }, desc = "Telescope [f]ind [h]elp" },
			{ "<leader>fd", function() require("telescope").extensions.spaceport.find() end, { "n" }, desc = "Telescope [f]ind spaceport [d]irectory" },
			{ "<leader>fn", function() require("telescope").extensions.notify.notify() end, { "n" }, desc = "Telescope [f]ind [n]otify" },
		},
	},
}
