vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false
vim.opt_local.colorcolumn = "80"

vim.treesitter.start()

vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"

if vim.loop.os_uname().sysname == "Linux" then
	vim.keymap.set("n", "<F5>", function()
		vim.cmd(":!wezterm start --cwd . --class floating dotnet run")
		vim.api.nvim_feedkeys("\r", "n", true)
	end, { buffer = true })
end

--highlight groups
vim.api.nvim_set_hl(0, "@comment.documentation.c_sharp", { fg = "#524f67" })
vim.api.nvim_set_hl(0, "@lsp.type.xmlDocCommentText.cs", { link = "comment" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6e6a86" })
