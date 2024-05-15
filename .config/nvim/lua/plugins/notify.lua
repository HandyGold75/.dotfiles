return { {
	"rcarriga/nvim-notify",
	name = "notify",
	config = function() vim.notify = require("notify") end,
} }
