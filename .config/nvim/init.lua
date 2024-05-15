-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Workaround for Gitsigns (https://github.com/neovim/neovim/pull/22846)
vim.uv = vim.loop

-- Load configs
require("config")
require("autocmds")

-- Load Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }) end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
