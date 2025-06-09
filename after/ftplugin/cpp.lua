vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false
vim.opt_local.colorcolumn = "80"

if vim.loop.os_uname().sysname == "Linux" then
	-- Build
	vim.keymap.set("n", "<f5>", ":!./build.sh debug\r\r", { buffer = true })
	-- Run
	vim.keymap.set("n", "<f17>", function()
		vim.print("Launch")
		vim.cmd("!wezterm start --cwd bin --always-new-process --class floating ./$(basename $PWD)")
		vim.api.nvim_feedkeys("\r", "n", true)
	end, { buffer = true })
else --Not Linux
	-- Build
	vim.keymap.set("n", "<f5>", ":!start build.bat debug\r\r", { buffer = true })
	-- Run
	vim.keymap.set("n", "<s-f5>", function()
		local cwd = vim.fn.substitute(vim.fn.getcwd(), "^.*\\", "", "")
		vim.cmd("!start Bin/" .. cwd)
		vim.api.nvim_feedkeys("\r", "n", true)
	end, { buffer = true })
end
vim.api.nvim_set_hl(0, "@lsp.type.namespace.cpp", { link = "@operator" })
vim.api.nvim_set_hl(0, "@module.cpp", { link = "@operator" })
vim.api.nvim_set_hl(0, "@lsp.typemod.class.defaultLibrary.cpp", { link = "Number" })
vim.api.nvim_set_hl(0, "@comment.documentation.cpp", { fg = "#274813" })
