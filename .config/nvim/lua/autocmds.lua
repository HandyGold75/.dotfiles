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

-- Mason Install All
vim.api.nvim_create_user_command("MasonInstallAll", function()
	vim.cmd("MasonInstall stylua goimports isort black beautysh prettierd prettier taplo xmlformatter")
	vim.cmd("MasonInstall pylint shellcheck htmlhint stylelint quick-lint-js markdownlint jsonlint yamllint")
	vim.cmd("MasonInstall gdtoolkit")
end, {})
