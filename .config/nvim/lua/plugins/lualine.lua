return {
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			icons_enabled = true,
			theme = "codedark",
			extenstions = { "lazy", "mason", "nvim-tree", "trouble" },
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
			always_divide_middle = true,
			always_show_tabline = true,

			sections = {

				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "filetype", "filesize" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
}
