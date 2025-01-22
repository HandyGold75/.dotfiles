return {
	{
		"nvim-tree/nvim-tree.lua",
		name = "tree",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = { enable = true, update_root = true },
		},
		cmd = { "NvimTreeOpen" },
		keys = {
			{ "<C-/>", ":NvimTreeToggle<CR>", { "n" }, silent = true, desc = "Toggle nvim tree" },
			{ "<C-_>", ":NvimTreeToggle<CR>", { "n" }, silent = true, desc = "Toggle nvim tree" },
			{
				"<leader>j",
				function()
					require("nvim-tree.api").node.navigate.sibling.next()
					require("nvim-tree.api").node.open.edit()
				end,
				{ "n" },
				silent = true,
				desc = "Open next file in nvim tree",
			},
			{
				"<leader>k",
				function()
					require("nvim-tree.api").node.navigate.sibling.prev()
					require("nvim-tree.api").node.open.edit()
				end,
				{ "n" },
				silent = true,
				desc = "Open previous file in nvim tree",
			},
		},
	},
}
