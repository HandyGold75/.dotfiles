-- Globals
vim.g.mapleader = ";"
vim.g.coq_settings = { ["auto_start"] = "shut-up" }

-- Settings
vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"

vim.opt.cursorline = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", nbsp = "⎵" }

vim.opt.scrolloff = 10
vim.opt.scroll = 1

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = true

vim.opt.spelllang = "en_us"
-- vim.opt.spell = false

-- vim.opt.foldcolumn = "1" -- Breaks spacesport visually
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"

-- Keymapping
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>")

vim.keymap.set("n", "<C-j>", "ddp")
vim.keymap.set("n", "<C-k>", "ddkP")

vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show [d]iagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [d]iagnostic [q]uickfix list" })
