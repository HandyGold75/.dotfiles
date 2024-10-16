-- General
vim.keymap.set({ "n" }, "<C-s>", ":wa<CR>", { silent = true, desc = "Save all buffers" })
vim.keymap.set({ "n" }, "<leader>tw", ":set wrap!<CR>", { silent = true, desc = "Warp [t]oggle [w]rap" })
vim.keymap.set({ "n" }, "<C-k>", "ddkP", { silent = true, desc = "Swap line with above" })
vim.keymap.set({ "n" }, "<C-j>", "ddp", { silent = true, desc = "Swap line with below" })

-- Yank, Cut, Paste
vim.keymap.set({ "n" }, "<C-c>", ":%y+<CR>", { silent = true, desc = "Yank buffer to clipboard" })
vim.keymap.set({ "v" }, "<C-c>", '"+y', { silent = true, desc = "Yank selection to clipboard" })
vim.keymap.set({ "v" }, "<C-x>", '"+d', { silent = true, desc = "Cut selection to clipboard" })

-- Debug
vim.keymap.set({ "n" }, "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Go to previous [d]iagnostic message" })
vim.keymap.set({ "n" }, "]d", vim.diagnostic.goto_next, { silent = true, desc = "Go to next [d]iagnostic message" })
vim.keymap.set({ "n" }, "<leader>de", vim.diagnostic.open_float, { silent = true, desc = "Show [d]iagnostic [e]rror messages" })
vim.keymap.set({ "n" }, "<leader>dq", vim.diagnostic.setloclist, { silent = true, desc = "Open [d]iagnostic [q]uickfix list" })

-- Behavioral
vim.keymap.set({ "c" }, "<Esc>", "<Esc>:nohlsearch<CR>", { silent = true, desc = "Disable highlight on escape" })
vim.keymap.set({ "i" }, "jj", "<Esc>jj", { silent = true, desc = "Escape insert mode going down" })
vim.keymap.set({ "i" }, "kk", "<Esc>kk", { silent = true, desc = "Escape insert mode going up" })
vim.keymap.set({ "n" }, "j", "jzz", { silent = true, desc = "Center going down" })
vim.keymap.set({ "n" }, "k", "kzz", { silent = true, desc = "Center going up" })
