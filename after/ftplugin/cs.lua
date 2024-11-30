vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

--highlight groups
vim.api.nvim_set_hl(0, "@lsp.type.keyword.cs", {})
vim.api.nvim_set_hl(0, "@lsp.type.struct.cs", { link = "Struct" })
vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@parameter", { link = "@variable.parameter" })
vim.api.nvim_set_hl(0, "@module", { link = "Special" })
vim.api.nvim_set_hl(0, "PreProc", { link = "Function" })
