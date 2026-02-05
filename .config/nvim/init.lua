-- Globals
vim.g.mapleader = ";"
vim.g.coq_settings = { ["auto_start"] = "shut-up" }

-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Options
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mouse = "nv"
vim.opt.undofile = true
vim.opt.smartindent = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", nbsp = "⎵", precedes = "…", extends = "…" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.laststatus = 3
vim.opt.showmode = false

vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- keybinds
vim.keymap.set({ "n" }, "<C-s>", ":wa<CR>", { noremap = true, desc = "Save all buffers" })
vim.keymap.set({ "n" }, "<leader>tw", ":set wrap!<CR>", { noremap = true, desc = "Warp [t]oggle [w]rap" })
vim.keymap.set({ "n" }, "<C-k>", "ddkP", { silent = true, noremap = true, desc = "Swap line with above" })
vim.keymap.set({ "n" }, "<C-j>", "ddp", { silent = true, noremap = true, desc = "Swap line with below" })

vim.keymap.set({ "n", "i", "v", "t" }, "<C-q>", "<ESC><C-\\><C-n>:wa<CR>:bd!<CR>", { noremap = true, desc = "Save and all buffers then close current buffer" })

vim.keymap.set({ "n" }, "<C-c>", ":%y+<CR>", { noremap = true, desc = "Yank buffer to clipboard" })
vim.keymap.set({ "v" }, "<C-c>", '"+y', { noremap = true, desc = "Yank selection to clipboard" })
vim.keymap.set({ "v" }, "<C-x>", '"+d', { noremap = true, desc = "Cut selection to clipboard" })

vim.keymap.set({ "i", "c" }, "<Esc>", "<Esc>:nohlsearch<CR>", { silent = true, noremap = true, desc = "Disable highlight on escape" })
vim.keymap.set({ "i" }, "jj", "<Esc>jj", { silent = true, noremap = true, desc = "Escape insert mode going down" })
vim.keymap.set({ "i" }, "kk", "<Esc>kk", { silent = true, noremap = true, desc = "Escape insert mode going up" })
vim.keymap.set({ "n" }, "j", "jzz", { silent = true, noremap = true, desc = "Center going down" })
vim.keymap.set({ "n" }, "k", "kzz", { silent = true, noremap = true, desc = "Center going up" })

-- autocmds

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Start spell when entering text buffer",
	group = vim.api.nvim_create_augroup("start-spell", { clear = true }),
	pattern = { "*.txt" },
	callback = function() vim.opt_local.spell = true end,
})

-- Load Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }) end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
	ui = { border = "rounded", title = "Lazy" },
	performance = { disabled_plugins = { rtp = { "netrwPlugin", "tohtml", "tutor" } } },
})
