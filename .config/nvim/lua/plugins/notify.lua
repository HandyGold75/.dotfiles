return { {
	"rcarriga/nvim-notify",
	name = "notify",
	event = { "VeryLazy" },
	config = function() vim.notify = require("notify") end,
} }
