return {
	{
		"folke/trouble.nvim",
		opts = {
			auto_close = true,
			-- auto_open = true,
			focus = true,
			modes = {
				preview_float = {
					mode = "diagnostics",
					preview = {
						type = "float",
						relative = "editor",
						border = "rounded",
						title = "Preview",
						title_pos = "center",
						position = { 0, -2 },
						size = { width = 1, height = 0.8 },
						zindex = 200,
					},
				},
			},
			keys = {
				["<esc>"] = "close",
				["<cr>"] = "jump_close",
				["<2-leftmouse>"] = "jump_close",
			},
		},
		cmd = "Trouble",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>td", ":Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
			-- { "<leader>tD", ":Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>ts", ":Trouble symbols toggle focus=true<CR>", desc = "Symbols (Trouble)" },
			{ "<leader>tr", ":Trouble lsp toggle win.position=right<CR>", desc = "LSP Definitions / references / ... (Trouble)" },
			-- { "<leader>to", ":Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
			-- { "<leader>tq", ":Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
		},
	},
}
