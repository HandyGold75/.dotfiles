-- General
vim.keymap.set({ "n" }, "<C-s>", ":wa<CR>", { desc = "Save all buffers" })
vim.keymap.set({ "n" }, "<leader>tw", ":set wrap!<CR>", { desc = "Do [t]oggle [w]rap" })
vim.keymap.set({ "n" }, "<C-k>", "ddkP", { desc = "Swap line with above" })
vim.keymap.set({ "n" }, "<C-j>", "ddp", { desc = "Swap line with below" })

-- Yank, Cut, Paste
vim.keymap.set({ "n" }, "<C-c>", ":%y+<CR>", { desc = "Yank buffer to clipboard" })
vim.keymap.set({ "v" }, "<C-c>", ":y+<CR>", { desc = "Yank selection to clipboard" })
vim.keymap.set({ "v" }, "<C-x>", ":d+<CR>", { desc = "Cut selection to clipboard" })

-- Debug
vim.keymap.set({ "n" }, "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
vim.keymap.set({ "n" }, "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
vim.keymap.set({ "n" }, "<leader>de", vim.diagnostic.open_float, { desc = "Show [d]iagnostic [e]rror messages" })
vim.keymap.set({ "n" }, "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [d]iagnostic [q]uickfix list" })

-- Behavioral
vim.keymap.set({ "c" }, "<Esc>", "<Esc>:nohlsearch<CR>", { desc = "Disable highlight on escape" })
vim.keymap.set({ "i" }, "jj", "<Esc>jj", { desc = "Escape insert mode going down" })
vim.keymap.set({ "i" }, "kk", "<Esc>kk", { desc = "Escape insert mode going up" })
vim.keymap.set({ "n" }, "j", "jzz", { desc = "Center going down" })
vim.keymap.set({ "n" }, "k", "kzz", { desc = "Center going up" })
