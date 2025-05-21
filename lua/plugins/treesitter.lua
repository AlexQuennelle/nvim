return {
	"nvim-treesitter/nvim-treesitter",
	build = "TSUpdate",
	dependencies = { "OXY2DEV/markview.nvim" },
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"lua",
				"cpp",
				"c_sharp",
				"javascript",
				"glsl",
				"haskell",
				"cmake",
				"typescript",
				"json",
				"html",
				"css",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
		vim.treesitter.language.register("glsl", "vert")
		vim.treesitter.language.register("glsl", "frag")
		vim.treesitter.language.register("glsl", "tesc")
		vim.treesitter.language.register("glsl", "tese")
		vim.treesitter.language.register("glsl", "geom")
		vim.treesitter.language.register("glsl", "comp")
	end,
}
