return {
	"OXY2DEV/markview.nvim",
	lazy = false,

	-- For blink.cmp's completion
	-- source
	-- dependencies = {
	--     "saghen/blink.cmp"
	-- },
	enabled = true,

	config = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "MarkviewAttach",
			callback = function(event)
				--- This will have all the data you need.
				--local data = event.data

				--vim.print(data)
				vim.print("attached")
			end,
		})
	end,

	opts = {
		preview = {
			icon_provider = "devicons",
			ignore_buftypes = {},
		},
		config = {
			experimental = {
				date_formats = {},
				date_time_formats = {},

				text_filetypes = {},
				read_chunk_size = 1000,
				link_open_alerts = false,
				prefer_nvim = true,
				file_open_command = "tabnew",

				list_empty_line_tolerance = 3,
			},
			highlight_groups = {},
			preview = {
				enable = true,
				filetypes = { "md", "rmd", "quarto" },
				ignore_buftypes = { "nofile" },
				ignore_previews = {},

				modes = { "n", "no", "c" },
				hybrid_modes = {},
				debounce = 50,
				draw_range = { vim.o.lines, vim.o.lines },
				edit_range = { 1, 0 },

				callbacks = {},

				splitview_winopts = { split = "left" },
			},
			renderers = {},

			html = {
				enable = true,

				container_elements = {},
				headings = {},
				void_elements = {},
			},
			latex = {
				enable = true,

				blocks = {},
				commands = {},
				escapes = {},
				fonts = {},
				inlines = {},
				parenthesis = {},
				subscripts = {},
				superscripts = {},
				symbols = {},
				texts = {},
			},
			markdown = {
				enable = true,

				block_quotes = {},
				code_blocks = {},
				headings = {},
				horizontal_rules = {},
				list_items = {},
				metadata_plus = {},
				metadata_minus = {},
				tables = {},
			},
			markdown_inline = {
				enable = true,

				block_references = {},
				checkboxes = {},
				emails = {},
				embed_files = {},
				entities = {},
				escapes = {},
				footnotes = {},
				highlights = {},
				hyperlinks = {},
				images = {},
				inline_codes = {},
				internal_links = {},
				uri_autolinks = {},
			},
			typst = {
				enable = true,

				codes = {},
				escapes = {},
				headings = {},
				labels = {},
				list_items = {},
				math_blocks = {},
				math_spans = {},
				raw_blocks = {},
				raw_spans = {},
				reference_links = {},
				subscripts = {},
				superscript = {},
				symbols = {},
				terms = {},
				url_links = {},
			},
			yaml = {
				enable = true,

				properties = {},
			},
		},
	},
}
