vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

if vim.loop.os_uname().sysname == "Linux" then
	vim.keymap.set("n", "<F5>", function()
		local file = vim.fn.expand("%")
		vim.cmd("!wezterm start --cwd . ghci " .. file)
		--vim.cmd("!hyprctl dispatch resizeactive -85 0")
		vim.api.nvim_feedkeys("\r", "n", true)
	end, { buffer = true })
else --Not Linux
	vim.print("Please Implement")
end

if 'g:colors_name' == "carbonfox" then
	vim.api.nvim_set_hl(0, "@variable.parameter.haskell", { link = "@property" })
end
