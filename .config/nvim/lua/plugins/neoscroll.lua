return {
	{
		"karb94/neoscroll.nvim",
		name = "neoscroll",
		config = function()
			neoscroll = require("neoscroll")
			neoscroll.setup({
				post_hook = function(info)
					if info == "center" then vim.defer_fn(function() neoscroll.zz({ half_win_duration = 100 }) end, 10) end
				end,
			})
			local keymap = {
				["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250, info = "center" }) end,
				["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250, info = "center" }) end,
				["<C-b>"] = function() neoscroll.ctrl_b({ duration = 500, info = "center" }) end,
				["<C-f>"] = function() neoscroll.ctrl_f({ duration = 500, info = "center" }) end,
				["<C-y>"] = function() neoscroll.scroll(-0.25, { move_cursor = false, duration = 100 }) end,
				["<C-e>"] = function() neoscroll.scroll(0.25, { move_cursor = false, duration = 100 }) end,
				["zz"] = function() neoscroll.zz({ half_win_duration = 100 }) end,
				["zt"] = function() neoscroll.zt({ half_win_duration = 100 }) end,
				["zb"] = function() neoscroll.zb({ half_win_duration = 100 }) end,
			}
			local modes = { "n", "v", "x" }
			for key, func in pairs(keymap) do
				vim.keymap.set(modes, key, func)
			end
		end,
		keys = {
			{ "<C-u>", ":lua require('neoscroll').ctrl_u({})<CR>", mode = { "n", "v", "x" } },
			{ "<C-d>", ":lua require('neoscroll').ctrl_d({})<CR>", mode = { "n", "v", "x" } },
			{ "<C-b>", ":lua require('neoscroll').ctrl_b({})<CR>", mode = { "n", "v", "x" } },
			{ "<C-f>", ":lua require('neoscroll').ctrl_f({})<CR>", mode = { "n", "v", "x" } },
			{ "<C-y>", ":lua require('neoscroll').scroll(0, {})<CR>", mode = { "n", "v", "x" } },
			{ "<C-e>", ":lua require('neoscroll').scroll(0, {})<CR>", mode = { "n", "v", "x" } },
			{ "zt", ":lua require('neoscroll').zt({})<CR>", mode = { "n", "v", "x" } },
			{ "zz", ":lua require('neoscroll').zz({})<CR>", mode = { "n", "v", "x" } },
			{ "zb", ":lua require('neoscroll').zb({})<CR>", mode = { "n", "v", "x" } },
		},
	},
}
