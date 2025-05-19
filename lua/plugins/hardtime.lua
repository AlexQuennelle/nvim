return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	lazy = false,
	-- opt = {},
	config = function()
		require("hardtime").setup()
	end,
}
