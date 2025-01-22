return {
	"nomnivore/ollama.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
	keys = {
		{ "<leader>oo", ":<c-u>lua require('ollama').prompt()<cr>", desc = "ollama prompt", mode = { "n", "v" } },
		{ "<leader>oG", ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>", desc = "ollama Generate Code", mode = { "n", "v" } },
	},
	opts = {
		model = "stable-code",
		url = "http://127.0.0.1:11434",
		serve = {
			on_start = true,
			command = "ollama",
			args = { "serve" },
			stop_command = "pkill",
			stop_args = { "-SIGTERM", "ollama" },
		},
		prompts = {},
	},
}
