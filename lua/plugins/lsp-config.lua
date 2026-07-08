return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				registries = {
					-- "github:crashdummyy/mason-registry",
					"github:mason-org/mason-registry",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"eslint",
					"glsl_analyzer",
					--"hls",
					"html",
					"jsonls",
					"lua_ls",
					"rust_analyzer",
					"roslyn_ls",
					"ts_ls",
					"neocmake",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				root_markers = { ".luarc.json" },
			})
			vim.lsp.enable({ "lua_ls" })
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "ts_ls" })
			vim.lsp.config("html", {
				capabilities = capabilities,
				nit_options = {
					provideFormatter = true,
					indentInnerHtml = false,
					embeddedLanguages = { css = true, javascript = true },
					configurationSection = { "html", "css", "javascript" },
				},
				settings = {
					html = {
						-- format = {
						-- 	templating = true,
						-- 	wrapLineLength = 80,
						-- 	wrapAttributes = "auto",
						-- },
						hover = {
							documentation = true,
							references = true,
						},
					},
				},
			})
			vim.lsp.enable({ "html" })

			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
			})
			vim.lsp.enable({ "clangd" })
			vim.lsp.config("glsl_analyzer", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "glsl_analyzer" })
			vim.lsp.config("hlsl_server", {
				capabilities = capabilities,
			})
			vim.lsp.enable("hlsl_server")
			vim.lsp.config("jsonls", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "jsonls" })
			vim.lsp.config("hls", {
				capabilities = capabilities,
				settings = {
					haskell = {
						hlintOn = true,
						plugin = {
							hlint = {
								globalOn = true,
								codeActionsOn = true,
							},
						},
					},
				},
			})
			vim.lsp.enable({ "hls" })
			-- vim.lsp.config("hlint", {
			-- 	capabilities = capabilities,
			-- })
			-- vim.lsp.enable({ "hlint" })
			vim.lsp.config("eslint", {
				settings = {
					packageManager = "npm",
				},
				---@diagnostic disable-next-line: unused-local
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				capabilities = capabilities,
			})
			vim.lsp.enable({ "eslint" })
			vim.lsp.config("neocmake", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "neocmake" })
			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "bashls" })
			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "rust_analyzer" })

			vim.lsp.enable({ "roslyn_ls" })
			vim.lsp.config("roslyn_ls", {
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<C-e>", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, {})
			-- vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
