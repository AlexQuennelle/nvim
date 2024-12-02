vim.cmd("runtime! ftplugin/javascript.lua")

vim.api.nvim_set_hl(0, "Special", { link = "@operator" })
