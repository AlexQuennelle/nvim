local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function (event)
		vim.opt.colorcolumn = "0"
	end
})

require("vim-options")
require("lazy").setup("plugins")
vim.cmd.colorscheme("rose-pine")
