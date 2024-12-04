vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Build
vim.keymap.set("n", "<f5>", ":!start build.bat\r\r")
-- Run
vim.keymap.set("n", "<s-f5>", function ()
	local cwd = vim.fn.substitute(vim.fn.getcwd(), '^.*\\', '', '')
	vim.cmd("!start Build/"..cwd)
	vim.api.nvim_feedkeys("\r", 'n', true)
end)

vim.api.nvim_set_hl(0, "@lsp.type.namespace.cpp", { link = "@operator" })
vim.api.nvim_set_hl(0, "@lsp.typemod.class.defaultLibrary.cpp", { link = "Number" })
vim.api.nvim_set_hl(0, "@comment.documentation.cpp", { fg = "#274813" })
