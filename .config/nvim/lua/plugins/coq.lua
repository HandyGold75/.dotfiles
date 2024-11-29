return { {
	"ms-jpq/coq_nvim",
	name = "coq",
	branch = "coq",
	dependencies = { "ms-jpq/coq.artifacts" },
	build = ":COQdeps",
	event = { "BufReadPre", "BufNewFile" },
} }
