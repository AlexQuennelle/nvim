return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	--{
	--	"jay-babu/mason-nvim-dap.nvim",
	--	config = function()
	--		require("mason-nvim-dap").setup({
	--			ensure_installed = { "codelldb" },
	--			automatic_installation = true,
	--		})
	--	end,
	--},
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
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.hls.setup({
				capabilities = capabilities,
			})
			lspconfig.eslint.setup({
				settings = {
					packageManager = "npm",
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				capabilities = capabilities,
			})

			lspconfig.omnisharp.setup({
				cmd = {
					"omnisharp",
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
			vim.keymap.set("n", "<C-e>", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
