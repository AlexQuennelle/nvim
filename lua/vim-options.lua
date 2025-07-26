vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.colorcolumn = ""

vim.opt.smartindent = true

vim.opt.showmode = false
vim.opt.winborder = "rounded"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.g.mapleader = " "
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 15

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars = {
	--tab = "┃ ",
	tab = "┆ ",
}

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

function _G.customFoldText()
	local line = vim.fn.getline(vim.v.foldstart)
	line = string.rep(" ", vim.fn.indent(vim.v.foldstart)) .. string.gsub(line, "^%s*", "")
	local lineCount = vim.v.foldend - vim.v.foldstart
	local lastLine = vim.fn.getline(vim.v.foldend)
	lastLine = string.gsub(lastLine, "^%s*", "")
	return line .. " ... " .. lastLine .. " (" .. lineCount .. ")"
end

function _G.altCustomFoldText()
	local line = vim.fn.getline(vim.v.foldstart)
	line = string.rep(" ", vim.fn.indent(vim.v.foldstart)) .. string.gsub(line, "^%s*", "")
	local nextLine = vim.fn.getline(vim.v.foldstart + 1)
	nextLine = string.gsub(nextLine, "^%s*", "")
	if #line >= 70 or string.sub(line, -1) == "," then
		line = string.gsub(line, "(%(.-,)(.*)", "%1 ...) {")
		line = string.gsub(line, "(%{)%{.*", "%1")
		nextLine = ""
	end
	local lastLine = vim.fn.getline(vim.v.foldend)
	lastLine = string.gsub(lastLine, "^%s*", "")
	lastLine = string.gsub(lastLine, "%}+", "}")
	local lineCount = vim.v.foldend - vim.v.foldstart
	if nextLine == "{" then
		return line .. " " .. nextLine .. "..." .. lastLine .. " (" .. lineCount .. ")"
	elseif string.sub(line, -1) == "{" then
		return line .. "...}; (" .. lineCount .. ")"
	elseif string.sub(lastLine, 1, 1) ~= "}" then
		return line .. " ... " .. lastLine .. " (" .. lineCount .. ")"
	else
		return line .. " ... (" .. lineCount .. ")"
	end
end

vim.opt.foldtext = "v:lua.customFoldText()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = -1
vim.opt.foldnestmax = 4
vim.opt.fillchars = { fold = " " }

vim.filetype.add({
	extension = {
		vert = "vert",
		frag = "frag",
		tesc = "tesc",
		tese = "tese",
		geom = "geom",
		comp = "comp",
		meta = "yaml",
		inputactions = "json",
	},
})

--keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-t>", ":tab terminal\n")
