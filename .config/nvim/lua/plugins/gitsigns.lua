return {
	{
		"lewis6991/gitsigns.nvim",
		name = "gitsigns",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> <relative_time> - <summary>",
				current_line_blame_formatter_opts = {
					relative_time = true,
				},
			})
		end,
		keys = {
			{ "<leader>hs", ":lua require('gitsigns').stage_hunk()<CR>", mode = { "n" } },
			{ "<leader>hr", ":lua require('gitsigns').reset_hunk()<CR>", mode = { "n" } },
			{ "<leader>hs", ":lua require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })<CR>", mode = { "n" } },
			{ "<leader>hr", ":lua require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })<CR>", mode = { "n" } },
			{ "<leader>hS", ":lua require('gitsigns').stage_buffer()<CR>", mode = { "n" } },
			{ "<leader>hu", ":lua require('gitsigns').undo_stage_hunk()<CR>", mode = { "n" } },
			{ "<leader>hR", ":lua require('gitsigns').reset_buffer()<CR>", mode = { "n" } },
			{ "<leader>hp", ":lua require('gitsigns').preview_hunk()<CR>", mode = { "n" } },
			{ "<leader>hb", ":lua require('gitsigns').blame_line({ full = ?true })<CR>", mode = { "n" } },
			{ "<leader>gb", ":lua require('gitsigns').toggle_current_line_blame()<CR>", mode = { "n" } },
			{ "<leader>hd", ":lua require('gitsigns').diffthis()<CR>", mode = { "n" } },
			{ "<leader>gd", ":lua require('gitsigns').toggle_deleted()<CR>", mode = { "n" } },
		},
	},
}
