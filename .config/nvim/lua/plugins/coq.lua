return {
	{
		"ms-jpq/coq_nvim",
		name = "coq",
		branch = "coq",
		dependencies = { "ms-jpq/coq.artifacts" },
		event = { "BufReadPre", "BufNewFile" },
	},
}
