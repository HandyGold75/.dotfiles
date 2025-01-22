return {
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.cmd("Lazy load markdown-preview.nvim")
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_open_to_the_world = 1
			vim.g.mkdp_open_ip = "127.0.0.1"
			vim.g.mkdp_port = 5051
			vim.g.mkdp_echo_preview_url = 1
			vim.g.mkdp_browser = "none"
		end,
	},
}
