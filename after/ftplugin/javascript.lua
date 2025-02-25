vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

--build--
vim.keymap.set("n", "<f5>", function()
	vim.cmd("w")
	vim.cmd("LiveServerStart")
end, { buffer = true })

--highlight groups--
vim.api.nvim_set_hl(0, "@comment.documentation.javascript", { fg = "#274813" })
vim.api.nvim_set_hl(0, "@keyword.function.javascript", { link = "@type.builtin" })
vim.api.nvim_set_hl(0, "@keyword.javascript", { link = "@type.builtin" })
vim.api.nvim_set_hl(0, "@function.method.call.javascript", { link = "@function.builtin" })
vim.api.nvim_set_hl(0, "@lsp.mod.static.javascript", { link = "keyword" })
