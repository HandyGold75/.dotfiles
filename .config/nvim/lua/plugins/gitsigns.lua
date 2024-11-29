return {
	{
		"lewis6991/gitsigns.nvim",
		name = "gitsigns",
		event = { "BufReadPre", "BufNewFile" },
		opts = { current_line_blame = true, current_line_blame_opts = { delay = 100 } },
		keys = {
			{ "<leader>hp", function() require("gitsigns").preview_hunk() end, { "n" }, desc = "Gitsigns [h]unk [p]review" },
			{ "<leader>hs", function() require("gitsigns").stage_hunk() end, { "n" }, desc = "Gitsigns [h]unk [s]tage" },
			{ "<leader>hS", function() require("gitsigns").stage_buffer() end, { "n" }, desc = "Gitsigns [h]unk [S]tage buffer" },
			{ "<leader>hr", function() require("gitsigns").reset_hunk() end, { "n" }, desc = "Gitsigns [h]unk [r]eset hunk" },
			{ "<leader>hR", function() require("gitsigns").reset_buffer() end, { "n" }, desc = "Gitsigns [h]unk [R]eset buffer" },
			{ "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, { "n" }, desc = "Gitsigns [h]unk [u]ndo stage" },
			{ "<leader>gt", function() require("gitsigns").diffthis() end, { "n" }, desc = "Gitsigns [g]it diff [t]his" },
			{ "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, { "n" }, desc = "Gitsigns [g]it [b]lame" },
			{ "<leader>gl", function() require("gitsigns").toggle_current_line_blame() end, { "n" }, desc = "Gitsigns toggle [g]it [l]ine blame" },
			{ "<leader>gd", function() require("gitsigns").toggle_deleted() end, { "n" }, desc = "Gitsigns toggle [g]it [d]eleted" },
		},
	},
}
