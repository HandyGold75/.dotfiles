return {
	{
		"ngtuonghy/live-server-nvim",
		name = "live-server-nvim",
		cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
		build = ":LiveServerInstall",
		config = function()
			require("live-server-nvim").setup({
				custom = {
					"--host=10.69.2.58",
					"--port=5500",
					"--no-browser",
					"--ignorePattern='.*\\.go'",
				},
			})
		end,
	},
}
