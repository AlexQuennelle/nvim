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
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"omnisharp",
					"clangd",
					"glsl_analyzer",
					"html",
					"tailwindcss",
					-- Formatters --
					--"eslint_d",
					--"prettierd",
					--"stylua",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.glsl_analyzer.setup({
				capabilities = capabilities,
			})

			local os = require("os")
			local omnisharpPath = os.getenv("OmniSharp")
			lspconfig.omnisharp.setup({
				cmd = {
					omnisharpPath,
				},
				-- settings = {
				-- 	formattingOptions = {
				-- 		enableEditorConfigSupport = true,
				-- 		-- organizeImports = true,
				-- 	},
				-- },
				capabilities = capabilities,
				enable_import_completion = true,
				organize_imports_on_format = true,
				enable_roslyn_analuzers = true,
				root_dir = function()
					return vim.loop.cwd()
				end,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
