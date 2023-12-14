-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Netrw explorer (o)" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Alt escape insert mode" })
-- take line below and append it to the end of the current line with a space
-- keeps the cursor in the same space as well
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join curr. line /w line below" })
-- jump half page up/down (c-d/c-u)
-- keeps the cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump 1/2 page up" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump 1/2 page down" })
-- jump to next/prev match while keeping the cursor centered on the screen
vim.keymap.set("n", "n", "nzzzv", { desc = "Search: next result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search: prev result" })

-- disable (no mapping for) capital Q with {rhs} = "<nop>"
vim.keymap.set("n", "Q", "<nop>", { desc = "none" })
