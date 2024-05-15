return {
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				theme = "codedark",
				extenstions = { "nvim-tree" },
				sections = {
					lualine_c = { "buffers" },
					lualine_x = { "encoding", "fileformat", "filesize" },
					lualine_y = { "filetype", "progress" },
				},
			})
		end,
	},
}
