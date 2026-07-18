return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				html = { "prettierd" },
				kdl = { "kdlfmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})

		vim.keymap.set("n", "<leader>gf", require("conform").format, {})
	end,
}
