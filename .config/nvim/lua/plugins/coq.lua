return {
	{
		"ms-jpq/coq_nvim",
		name = "coq",
		branch = "coq",
		dependencies = { "ms-jpq/coq.artifacts", "ms-jpq/coq.thirdparty" },
		build = ":COQdeps",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"ms-jpq/coq_nvim",
		name = "coq",
		branch = "coq",
		dependencies = { "ms-jpq/coq.thirdparty" },
		build = ":COQdeps",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("coq_3p").setup({
				{ src = "builtin/css" },
				{ src = "builtin/html" },
				{ src = "builtin/js" },
				{ src = "builtin/syntax" },
				{ src = "builtin/xml" },
				{
					src = "repl",
					sh = "bash",
					shell = {},
					max_lines = 100,
					deadline = 1000,
					unsafe = { "rm", "poweroff", "mv", "shutdown", "reboot", "cp", "dd" },
				},
				{ src = "nvimlua", short_name = "LUA", conf_only = false },
				{ src = "bc", short_name = "MATH", precision = 6 },
			})
		end,
	},
}
