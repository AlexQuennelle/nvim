return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				registries = { "github:crashdummyy/mason-registry", "github:mason-org/mason-registry" },
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
					-- "roslyn",
					-- "omnisharp",
					-- "tailwindcss",
					"ts_ls",
					"neocmake",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		--dependencies = { 'saghen/blink.cmp' },
		--opts = {
		--	servers = {
		--		lua_ls = {}
		--	}
		--},
		--config = function(_, opts)
		--	local lspconfig = require('lspconfig')
		--	for server, config in pairs(opts.servers) do
		--		config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
		--		lspconfig[server].setup(config)
		--	end
		--end
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			--local lspconfig = require("lspconfig")
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				root_markers = { ".luarc.json" },
			})
			vim.lsp.enable({ "lua_ls" })
			--lspconfig.lua_ls.setup({
			--	capabilities = capabilities,
			--})
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
			vim.lsp.config("jsonls", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "jsonls" })
			vim.lsp.config("hls", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "hls" })
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
			vim.lsp.config("hyprls", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "hyprls" })
			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "bashls" })
			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
			})
			vim.lsp.enable({ "rust_analyzer" })

			vim.lsp.enable({ "roslyn" })
			vim.lsp.config("roslyn", {
				capabilities = capabilities,
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						csharp_enable_inlay_hints_for_types = false,
						dotnet_enable_inlay_hints_for_indexer_parameters = true,
						dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
						dotnet_enable_inlay_hints_for_other_parameters = true,
						dotnet_enable_inlay_hints_for_parameters = true,
						dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
					["csharp|completions"] = {
						dotnet_show_completion_items_from_unimported_namespaces = true,
						dotnet_show_name_completion_suggestions = true,
					},
				},
			})

			-- vim.lsp.config("omnisharp", {
			-- 	cmd = {
			-- 		"/usr/bin/OmniSharp",
			-- 	},
			-- 	capabilities = capabilities,
			-- 	enable_import_completion = true,
			-- 	organize_imports_on_format = true,
			-- 	enable_roslyn_analyzers = true,
			-- 	root_dir = function()
			-- 		return vim.loop.cwd()
			-- 	end,
			-- })
			-- vim.lsp.enable({ "omnisharp" })

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
