return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	name = "nightfox",
	priority = 1000,
	config = function()
		require("nightfox").setup({
			options = {
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "underline,bold",
				},
			},
			palettes = {
				all = {
					comment = "#276013",
				},
			},
			specs = {
				all = {
					syntax = {
						builtin1 = "#2560aa",
						variable = "#d0efff",
					},
				},
			},
			groups = {
				all = {
					DiagnosticUnnecessary = {
						fg = "fg2",
						style = "italic",
					},
					Struct = {
						fg = "#68b858",
						style = "bold,underline",
					},
					Function = {
						link = "keyword",
					},
				},
			},
		})
		vim.cmd.colorscheme("carbonfox")
		vim.api.nvim_set_hl(0, "@tag.delimiter.html", { link = "@punctuation" })
		vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable.member" })
		vim.api.nvim_set_hl(0, "@parameter", { link = "@variable.parameter" })
	end,
}
