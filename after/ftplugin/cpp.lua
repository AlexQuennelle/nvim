vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.api.nvim_set_hl(0, "@lsp.type.namespace.cpp", { link = "@operator" })
vim.api.nvim_set_hl(0, "@lsp.typemod.class.defaultLibrary.cpp", { link = "Number" })
vim.api.nvim_set_hl(0, "@comment.documentation.cpp", { fg = "#274813" })
