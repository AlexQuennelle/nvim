vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false
vim.opt_local.colorcolumn = "80"

--highlight groups
vim.api.nvim_set_hl(0, "@comment.documentation.c_sharp", { fg = "#274813" })
vim.api.nvim_set_hl(0, "@lsp.type.xmlDocCommentText.cs", { link = "comment" })
vim.api.nvim_set_hl(0, "@keyword.modifier.c_sharp", { fg = "#2560aa", bold = true })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.cs", {})
vim.api.nvim_set_hl(0, "@lsp.type.struct.cs", { link = "Struct" })
vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@parameter", { link = "@variable.parameter" })
vim.api.nvim_set_hl(0, "@module", { link = "Special" })
vim.api.nvim_set_hl(0, "PreProc", { fg = "#2560aa" })
vim.api.nvim_set_hl(0, "@lsp.type.macro.cs", { link = "Conceal" })
vim.api.nvim_set_hl(0, "@lsp.type.preprocessorText.cs", { link = "Operator" })
