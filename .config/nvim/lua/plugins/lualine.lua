return {
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				theme = "codedark",
				extenstions = { "lazy", "mason", "nvim-tree", "trouble" },
				sections = {
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filesize" },
					lualine_y = { "filetype", "progress" },
				},
			})
		end,
	},
}
