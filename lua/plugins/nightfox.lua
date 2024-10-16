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
					comment = "#3f802d",
				},
			},
		})
		vim.cmd.colorscheme("carbonfox")
	end,
}
