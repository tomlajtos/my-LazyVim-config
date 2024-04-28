-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = true

vim.opt.autowrite = false
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.clipboard = "unnamed,unnamedplus"
