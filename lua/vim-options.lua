vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.colorcolumn = ""

vim.opt.spell = true
vim.opt.spelllang = "en_ca"

-- vim.lsp.set_log_level("DEBUG")
-- vim.lsp.inlay_hint.enable()

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

local highlight_cache = {}
function GetHighlights(foldText, lineNr)
	local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
	local parser = vim.treesitter.get_parser(0, lang)
	local query = vim.treesitter.query.get(parser:lang(), "highlights")

	local tree = parser:parse({ lineNr - 1, lineNr })[1]
	local result = foldText
	local linePos = 0
	local prevRange = nil

	local acc = {}
	local indent = false
	for id, node, _ in query:iter_captures(tree:root(), 0, lineNr - 1, lineNr) do
		local name = query.captures[id]
		local startRow, startCol, endRow, endCol = node:range()
		if startRow == lineNr - 1 and endRow == lineNr - 1 then
			table.insert(acc, { linePos, { startCol, endCol } })
			local range = { startCol, endCol }
			if startCol > linePos then
				--acc = acc + 1
				if indent then
					table.insert(result, { " ", "Folded" })
				else
					indent = true
				end
				--table.insert(result, { line:sub(linePos + 1, startCol), "Folded" })
			else
				indent = true
			end
			linePos = endCol

			local merged_hl = "Folded_" .. string.gsub(name, "@", "")

			if not highlight_cache[merged_hl] then
				local mod_hl = vim.api.nvim_get_hl_by_name("@" .. name, true)
				local final_hl = vim.tbl_deep_extend("force", mod_hl, {
					underline = true,
					special = "#6e6a86",
				})
				vim.api.nvim_set_hl(0, merged_hl, final_hl)
				highlight_cache[merged_hl] = true
			end

			local text = vim.treesitter.get_node_text(node, 0)
			if prevRange ~= nil and range[1] == prevRange[1] and range[2] == prevRange[2] then
				result[#result] = { text, merged_hl }
				--result[#result] = { text, "@" .. name }
				--prevRange = range
			elseif prevRange ~= nil and range[2] <= prevRange[2] then
				-- Do nothing
				result[#result] = { string.sub(result[#result][1], 1, range[1] - prevRange[1]), result[#result][2] }
				table.insert(result, { text, merged_hl })
			else
				--table.insert(result, { text, "@" .. name })
				--table.insert(result, { text, "Folded" })
				table.insert(result, { text, merged_hl })
			end
			prevRange = range
		end
	end
	--vim.print(acc)
	return result
end

function _G.customFoldText()
	local start = vim.v.foldstart
	local endPos = vim.v.foldend
	local lineCount = endPos - start

	local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
	local parser = vim.treesitter.get_parser(0, lang)
	local query = vim.treesitter.query.get(parser:lang(), "highlights")

	if query == nil then
		local line = vim.fn.getline(start)
		line = string.rep(" ", vim.fn.indent(start)) .. string.gsub(line, "^%s*", "")
		local lastLine = vim.fn.getline(endPos)
		lastLine = string.gsub(lastLine, "^%s*", "")
		return line .. " ... " .. lastLine .. " (" .. lineCount .. ")"
	end

	local result = {}
	table.insert(result, { string.rep(" ", vim.fn.indent(start)), "Folded" })
	result = GetHighlights(result, start)
	table.insert(result, { " ... ", "Folded" })
	result = GetHighlights(result, endPos)
	table.insert(result, { " (" .. lineCount .. ")", "Folded" })

	return result
end

function _G.altCustomFoldText()
	local start = vim.v.foldstart
	local endPos = vim.v.foldend
	local lineCount = endPos - start

	local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
	local parser = vim.treesitter.get_parser(0, lang)
	local query = vim.treesitter.query.get(parser:lang(), "highlights")

	-- Handle case without language
	if query == nil then
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

	local result = {}
	table.insert(result, { string.rep(" ", vim.fn.indent(start)), "Folded" })
	result = GetHighlights(result, start)

	local length = 0
	for i = 1, #result do
		length = length + #result[i][1]
	end
	if length >= 70 or string.sub(vim.fn.getline(start), -1) == "," then
		local trimmed = {}
		for i = 1, #result do
			table.insert(trimmed, result[i])
			if result[i][1] == "," then
				break
			end
		end
		result = trimmed
		table.insert(result, { " ...", "Folded" })
		table.insert(result, { ")", "Folded_punctuation.bracket" })
	end

	--vim.print(result)
	table.insert(result, { " (" .. lineCount .. ")", "Folded" })
	return result
end

vim.opt.foldtext = "v:lua.customFoldText()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})
vim.lsp.codelens.enable()
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = -1
vim.opt.foldnestmax = 4
vim.opt.fillchars = { fold = " " }

vim.filetype.add({
	extension = {
		hlsl = "hlsl",
		vert = "vert",
		frag = "frag",
		tesc = "tesc",
		tese = "tese",
		geom = "geom",
		comp = "comp",
		meta = "yaml",
		inputactions = "json",
		conf = "ini",
	},
})

--keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-t>", ":tab terminal\n:setlocal nospell\n")
