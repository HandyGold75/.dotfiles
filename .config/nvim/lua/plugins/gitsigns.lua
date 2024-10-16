return {
	{
		"lewis6991/gitsigns.nvim",
		name = "gitsigns",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 100,
				},
			})
		end,
		keys = {
			{ "<leader>hp", ":lua require('gitsigns').preview_hunk()<CR>", { "n" }, silent = true, desc = "Gitsigns [h]unk [p]review" },
			{ "<leader>hs", ":lua require('gitsigns').stage_hunk()<CR>", { "n" }, silent = true, desc = "Gitsigns [h]unk [s]tage" },
			{ "<leader>hS", ":lua require('gitsigns').stage_buffer()<CR>", { "n" }, silent = true, desc = "Gitsigns [h]unk [S]tage buffer" },
			{ "<leader>hr", ":lua require('gitsigns').reset_hunk()<CR>", { "n" }, silent = true, desc = "Gitsigns [h]unk [r]eset hunk" },
			{ "<leader>hR", ":lua require('gitsigns').reset_buffer()<CR>", { "n" }, silent = true, desc = "Gitsigns [h]unk [R]eset buffer" },
			{ "<leader>hu", ":lua require('gitsigns').undo_stage_hunk()<CR>", { "n" }, silent = true, desc = "Gitsigns [h]unk [u]ndo stage" },
			{ "<leader>gt", ":lua require('gitsigns').diffthis()<CR>", { "n" }, silent = true, desc = "Gitsigns [g]it diff [t]his" },
			{ "<leader>gb", ":lua require('gitsigns').blame_line({ full = true })<CR>", { "n" }, silent = true, desc = "Gitsigns [g]it [b]lame" },
			{ "<leader>gl", ":lua require('gitsigns').toggle_current_line_blame()<CR>", { "n" }, silent = true, desc = "Gitsigns toggle [g]it [l]ine blame" },
			{ "<leader>gd", ":lua require('gitsigns').toggle_deleted()<CR>", { "n" }, silent = true, desc = "Gitsigns toggle [g]it deleted" },
		},
	},
}
