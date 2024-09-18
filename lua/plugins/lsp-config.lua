return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_intsalled = {
					"lua_ls",
					"ts_ls",
					--"omnisharp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.ts_ls.setup({})

			local pid = vim.fn.getpid()
			local omnisharp_bin = "C:\\Users\\phoen\\AppData\\Local\\bin\\omnisharp-roslyn\\Omnisharp.exe"
			lspconfig.omnisharp.setup({
				cmd = {
					omnisharp_bin,
					"--languageserver",
					"--hostPID",
					tostring(pid),
				},
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
--lspconfig.omnisharp.setup({})
