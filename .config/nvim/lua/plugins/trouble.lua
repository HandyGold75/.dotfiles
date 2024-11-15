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
			{ "<leader>td", ":Trouble diagnostics toggle<CR>", { "n" }, desc = "Trouble [t]oggle [d]iagnostics" },
			{ "<leader>tD", ":Trouble diagnostics toggle filter.buf=0<CR>", { "n" }, desc = "Trouble [t]oggle buffer [D]iagnostics" },
			{ "<leader>ts", ":Trouble symbols toggle focus=true<CR>", { "n" }, desc = "Trouble [t]oggle [s]ymbols" },
			{ "<leader>tr", ":Trouble lsp toggle win.position=right<CR>", { "n" }, desc = "Trouble [t]oggle LSP [r]eferences" },
			{ "<leader>to", ":Trouble loclist toggle<CR>", { "n" }, desc = "Trouble [t]oggle l[o]cation list" },
			{ "<leader>tq", ":Trouble qflist toggle<CR>", { "n" }, desc = "Trouble [t]oggle [q]uickfix list" },
		},
	},
}
