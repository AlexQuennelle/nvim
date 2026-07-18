---@type vim.lsp.config
return {
	cmd = {
		"/home/Alex/.vscode-oss/extensions/antaalt.shader-validator-1.4.0-linux-x64/bin/linux-x64/shader-language-server",
	},
	filetypes = { "hlsl" },
	root_markers = { ".git" },
	settings = {
		shader_validator = {
			hlsl = {
				enabled = true,
			}
		}
	}
}
