vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")

vim.g.mapleader=" "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 15

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars = {
	tab = "| ",
}

vim.keymap.set('n', '<Esc>', "<cmd>noh\n")
