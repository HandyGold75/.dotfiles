return {
	{
		"nvim-tree/nvim-tree.lua",
		name = "tree",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = { enable = true, update_root = true },
			})
		end,
		cmd = { "NvimTreeOpen" },
		keys = {
			{ "<C-_>", ":NvimTreeToggle<CR>", { "n" }, silent = true, desc = "Toggle nvim tree" },
		},
	},
}
