-- Yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

-- Enable spell
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Start spell when entering text buffer",
	group = vim.api.nvim_create_augroup("start-spell", { clear = true }),
	pattern = { "*.txt" },
	callback = function() vim.opt_local.spell = true end,
})
