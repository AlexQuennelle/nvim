return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"igorlfs/nvim-dap-view",
		{
			"ownself/nvim-dap-unity",
			build = function()
				require("nvim-dap-unity").install()
			end,
		},
	},
	config = function()
		local dap = require("dap")

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set pretty print on" },
		}
		dap.configurations.c = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function() -- Function to get executable
					local defaultBinPath = vim.fn.getcwd() .. "/bin/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					if vim.fn.filereadable(defaultBinPath) == 1 then
						return defaultBinPath
					else
						vim.cmd("!./build.sh debug")
						vim.api.nvim_feedkeys("\r", "n", true)
						if vim.fn.filereadable(defaultBinPath) == 1 then
							return defaultBinPath
						else
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end
					end
				end,
				args = {}, -- provide arguments if needed
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.cpp = dap.configurations.c

		require("nvim-dap-unity").setup()

		dap.adapters.coreclr = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
			args = { "--interpreter=vscode" },
		}
		dap.configurations.cs = dap.configurations.cs or {}
		vim.list_extend(dap.configurations.cs, {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
				end,
			},
		})

		vim.api.nvim_set_hl(0, "DapStopped", { bg = "#26233a", bold = true })
		vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#9ccfd8" })
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#eb6f92" })
		vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#f6c177" })

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapStopped",
			{ text = "󰜴", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)

		require("dap-view").setup({
			winbar = {
				sections = {
					"watches",
					"scopes",
					"breakpoints",
					"threads",
					"repl",
					"console",
					"sessions",
				},
			},
		})

		local debugMappings = {
			{ key = "K", mapped = false, map = {} },
			{ key = "<C-K>", mapped = false, map = {} },
			{ key = "<F5>", mapped = false, map = {} },
		}
		local bufRestore = {}
		dap.listeners.after["event_initialized"]["me"] = function()
			require("dap-view").open()
			for _, buf in pairs(vim.api.nvim_list_bufs()) do
				bufRestore[buf] = vim.deepcopy(debugMappings)
				local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
				for _, keymap in pairs(keymaps) do
					if keymap.lhs == "K" then
						bufRestore[buf][1].mapped = true
						bufRestore[buf][1].map = keymap
						vim.api.nvim_buf_del_keymap(buf, "n", "K")
					elseif keymap.lhs == "<CS-K>" then
						bufRestore[buf][2].mapped = true
						bufRestore[buf][2].map = keymap
						vim.api.nvim_buf_del_keymap(buf, "n", "<C-K>")
					elseif keymap.lhs == "<F5>" then
						bufRestore[buf][3].mapped = true
						bufRestore[buf][3].map = keymap
						vim.api.nvim_buf_del_keymap(buf, "n", "<F5>")
					end
				end
				vim.keymap.set("n", "K", require("dap-view").hover, { buffer = buf })
				vim.keymap.set("n", "<C-K>", ":DapViewWatch\r", { buffer = buf, silent = true })
				vim.keymap.set("n", "<F5>", function(opts)
					opts = require("telescope.themes").get_dropdown({})
					local list = {
						{ name = "Continue", func = dap.continue },
						{ name = "Terminate", func = dap.terminate },
						{ name = "Run to cursor", func = dap.run_to_cursor },
					}
					require("telescope.pickers")
						.new(opts, {
							prompt_title = "DAP options",
							finder = require("telescope.finders").new_table({
								results = list,
								entry_maker = function(entry)
									return {
										value = entry.func,
										display = entry.name,
										ordinal = entry.name,
									}
								end,
							}),
							sorter = require("telescope.config").values.generic_sorter(opts),
							attach_mappings = function(prompt_bufnr, map)
								local actions = require("telescope.actions")
								actions.select_default:replace(function()
									actions.close(prompt_bufnr)
									local selection = require("telescope.actions.state").get_selected_entry()
									selection.value()
								end)
								return true
							end,
						})
						:find()
				end, { buffer = buf })
			end
			vim.keymap.set("n", "<Down>", dap.step_over, { silent = true })
			vim.keymap.set("n", "<Right>", dap.step_into, { silent = true })
			vim.keymap.set("n", "<Up>", dap.step_out, { silent = true })
			vim.keymap.set("n", "<Left>", dap.step_back, { silent = true })
		end

		dap.listeners.after["event_terminated"]["me"] = function()
			require("dap-view").close()
			for i, buf in ipairs(bufRestore) do
				for _, keymap in pairs(buf) do
					if keymap.mapped then
						if keymap.map.rhs then
							vim.api.nvim_buf_set_keymap(
								keymap.map.buffer,
								keymap.map.mode,
								keymap.map.lhs,
								keymap.map.rhs,
								{ silent = keymap.map.silent == 1 }
							)
						elseif keymap.map.callback then
							vim.keymap.set(
								keymap.map.mode,
								keymap.map.lhs,
								keymap.map.callback,
								{ buffer = keymap.map.buffer, silent = keymap.silent == 1 }
							)
						end
					else
						vim.api.nvim_buf_del_keymap(i, "n", keymap.key)
					end
				end
			end
			bufRestore = {}
			vim.keymap.del("n", "<Down>")
			vim.keymap.del("n", "<Right>")
			vim.keymap.del("n", "<Up>")
			vim.keymap.del("n", "<Left>")
		end

		vim.keymap.set("n", "<C-b>", ":DapToggleBreakpoint\r", { silent = true })
		vim.keymap.set("n", "<CS-b>", ":DapClearBreakpoints\r", { silent = true })
	end,
}
