-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Netrw: open explorer" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "<Esc> alternative, insert mode" })
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Write current buffer" })

-- take line below and append it to the end of the current line with a space
-- keeps the cursor in the same space as well
vim.keymap.set("n", "J", "mzJ`z", { desc = "" })
-- jump half page up/down (c-d/c-u)
-- keeps the cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump 1/2 page up" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump 1/2 page down" })
-- jump to next/prev match while keeping the cursor centered on the screen
vim.keymap.set("n", "n", "nzzzv", { desc = "" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "" })

vim.keymap.set("n", "Q", "<nop>", { desc = "" })

-- preserve current paste buffer whan copying over highlighted pattern
-- vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "" })

-- deleting to void register  so deleted pattern is not preserved
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "" })

vim.keymap.set("n", "Q", "<nop>", { desc = "" })
