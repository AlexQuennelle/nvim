vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false
vim.opt_local.colorcolumn = "80"

vim.treesitter.start()

vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"
vim.opt.foldtext = "v:lua.altCustomFoldText()"

vim.lsp.inlay_hint.enable(false)

if os.getenv("WSL_INTEROP") ~= nil or os.getenv("WSL_DISTRO_NAME") ~= nil then
	-- Check for WSL
	vim.keymap.set("n", "<f5>", ":!Powershell.exe /c start build.bat debug\r\r", { buffer = true })
elseif vim.loop.os_uname().sysname == "Linux" then
	-- Build
	vim.keymap.set("n", "<f5>", ":!./build.sh debug\r\r", { buffer = true })
	-- Run
	vim.keymap.set("n", "<f17>", function()
		vim.print("Launch")
		vim.cmd("!wezterm start --cwd bin --class floating ./$(basename $PWD)")
		vim.api.nvim_feedkeys("\r", "n", true)
	end, { buffer = true })
	--vim.keymap.set("n", "<C-b>", "o#ifndef NDEBUG\nraise(SIGTRAP);\n#endif<Esc>")
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
if vim.g.colors_name == "carbonfox" then
	vim.api.nvim_set_hl(0, "@lsp.type.namespace.cpp", { link = "@operator" })
	vim.api.nvim_set_hl(0, "@module.cpp", { link = "@operator" })
	vim.api.nvim_set_hl(0, "@lsp.typemod.class.defaultLibrary.cpp", { link = "Number" })
	vim.api.nvim_set_hl(0, "@comment.documentation.cpp", { fg = "#274813" })
elseif vim.g.colors_name == "rose-pine" then
	vim.api.nvim_set_hl(0, "@comment.documentation.cpp", { fg = "#524f67", bold = true })
	vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6e6a86" })
end
