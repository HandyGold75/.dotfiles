return {
	{
		"ngtuonghy/live-server-nvim",
		name = "live-server",
		build = ":LiveServerInstall",
		cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
		opts = { custom = { "--host=10.69.2.58", "--port=5500", "--no-browser", "--ignorePattern='.*\\.go'" } },
	},
}
