return {
	{
		"CWood-sdf/spaceport.nvim",
		name = "spaceport",
		lazy = false,
		config = function()
			local _local_remaps = {
				lines = {},
				topBuffer = 0,
				title = nil,
				remaps = {
					{ mode = "n", key = "h", description = " Home", action = function() require("spaceport.data").cd({ dir = "~/", isDir = true }) end },
					{ mode = "n", key = "df", description = " DotFiles", action = function() require("spaceport.data").cd({ dir = "~/.dotfiles/", isDir = true }) end },
					{ mode = "n", key = "l", description = "󰒲 Lazy", action = ":Lazy<CR>" },
					{ mode = "n", key = "m", description = " Mason", action = ":Mason<CR>" },
				},
			}

			vim.api.nvim_set_hl(0, "SpaceportRemapTitle", { fg = "#9999FF" })
			vim.api.nvim_set_hl(0, "SpaceportRecentsTitle", { fg = "#9999FF" })

			require("spaceport").setup({
				projectEntry = "NvimTreeOpen",
				replaceHome = true,
				lastViewTime = "pastMonth",
				sections = { { "name", config = { style = "lite", gradient = "blue" } }, "remaps", _local_remaps, "recents", "hacker_news" },
			})
		end,
		cmd = { "Spaceport" },
		keys = { { "<leader>sp", ":Spaceport<CR>", { "n" }, desc = "[s]pace[p]ort" } },
	},
}
