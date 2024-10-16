-- Globals
vim.g.mapleader = ";"
vim.g.coq_settings = { ["auto_start"] = "shut-up" }

-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load configs
require("options")
require("keybinds")
require("autocmds")

-- Load Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }) end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
	ui = { border = "single", title = "Lazy" },
	performance = { disabled_plugins = { rtp = { "netrwPlugin", "tohtml", "tutor" } } },
})
