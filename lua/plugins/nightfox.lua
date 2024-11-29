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
			specs = {
				all = {
					syntax = {
						builtin1 = "#3882e2",
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
				},
			},
		})
		vim.cmd.colorscheme("carbonfox")
		vim.api.nvim_create_autocmd("LspTokenUpdate", {
			callback = function(args)
				local token = args.data.token
				if token.type == "variable" and not token.modifiers.readonly then
					vim.lsp.semantic_tokens.highlight_token(
						token,
						args.buf,
						args.data.client_id,
						{
							line = token.line,
							start_col = token.start_col,
							end_col = token.end_col,
							type = "@type",
							modifiers = token.modifiers,
							client_id = token.client_id,
						}
					)
				end
			end,
		})
	end,
}
