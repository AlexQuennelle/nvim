vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.g.mapleader = " "
vim.g.have_nerd_font = true

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

--keymaps
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-l>", function()
	YoinkL()
end)

function YoinkL()
	--vim.cmd("")
end
