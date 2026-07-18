return {
	{
		"nvim-telescope/telescope.nvim",
		--tag = "0.1.8",
		-- branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- HACK: Force cmake minimum version
				build = "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		config = function()
			local builtin = require("telescope.builtin")
			-- Keymaps
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fh", function()
				builtin.find_files({
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				})
			end, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics bufnr=0\n", {})
			vim.keymap.set("n", "<leader>fD", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, {})
			vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>td", ":TodoTelescope layout_config={height=0.45} theme=ivy\n", {})
			vim.keymap.set("n", "<leader>?", builtin.help_tags, {})
			vim.keymap.set("n", "/", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("n", "z=", builtin.spell_suggest, {})

			local actions = require("telescope.actions")
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
				pickers = {
					diagnostics = {
						theme = "ivy",
						layout_config = {
							height = 0.45,
						},
					},
					current_buffer_fuzzy_find = {
						theme = "dropdown",
						layout_config = {
							prompt_position = "top",
							height = vim.o.lines,
							width = vim.o.columns,
						},
					},
					spell_suggest = {
						theme = "cursor",
					},
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")

			-- HACK: hacky fix for picker border
			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopeFindPre",
				callback = function()
					vim.opt_local.winborder = "none"
					vim.api.nvim_create_autocmd("WinLeave", {
						once = true,
						callback = function()
							vim.opt_local.winborder = "rounded"
						end,
					})
				end,
			})
		end,
	},
}
