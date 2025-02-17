vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

--build--
vim.keymap.set("n", "<f5>", function()
	vim.cmd("w")
	vim.cmd("LiveServerStart")
end, { buffer = true })
