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
			{ "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			-- { "<leader>tD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>ts", "<cmd>Trouble symbols toggle focus=true<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>tr", "<cmd>Trouble lsp toggle win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
			-- { "<leader>to", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			-- { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},
}
