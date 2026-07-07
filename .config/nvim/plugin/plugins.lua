vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/mosheavni/yaml-companion.nvim" },
	{ src = "https://github.com/b0o/SchemaStore.nvim" },

	{ src = "https://github.com/Mofiqul/vscode.nvim" },

	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },

	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },

	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	{ src = "https://github.com/nvim-telescope/telescope.nvim" },

	{ src = "https://github.com/MagicDuck/grug-far.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },

	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },

	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("vscode").setup()
vim.cmd.colorscheme("vscode")

require("lualine").setup({
	options = {
		section_separators = "",
		component_separators = "",
		disabled_filetypes = {
			statusline = { "NvimTree" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 3 } },
		lualine_x = { "encoding", "fileformat", "filetype", "lsp_status" },
		lualine_y = { "progress" },
		lualine_z = { "location", "searchcount", "selectioncount" },
	},
	tabline = {
		lualine_c = {
			{
				"buffers",
				show_filename_only = true,
				ignore_focus = { "NvimTree" },
				filetype_names = {
					NvimTree = "",
				},
			},
		},
		lualine_x = { "tabs" },
	},
})
require("which-key").setup({
	preset = "helix",
	delay = 0,
	filter = function(mapping)
		return mapping.desc and mapping.desc ~= ""
	end,
})

require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("guess-indent").setup()

require("gitsigns").setup()

require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		fish = { "fish_indent" },
	},
})

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

require("grug-far").setup()
require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
	},
	view = {
		width = 50,
	},
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		api.config.mappings.default_on_attach(bufnr)

		vim.keymap.set("n", "o", function()
			api.node.open.edit(nil, { focus = true })
		end, opts("Open No Focus"))

		vim.keymap.set("x", "o", function()
			local nodes = require("nvim-tree.utils").get_visual_nodes() or {}
			for _, node in ipairs(nodes) do
				if node.type == "file" or node.type == "link" then
					api.node.open.edit(node, { focus = true })
				end
			end
		end, opts("Open No Focus Selected Files"))

		vim.keymap.set("x", "<CR>", function()
			local nodes = require("nvim-tree.utils").get_visual_nodes() or {}
			for _, node in ipairs(nodes) do
				if node.type == "file" or node.type == "link" then
					api.node.open.edit(node)
				end
			end
		end, opts("Open Selected Files"))
	end,
})

require("luasnip").setup()
require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},
	cmdline = {
		completion = {
			menu = { auto_show = false },
		},
		keymap = {
			["<C-e>"] = { "cancel", "fallback" },
			["<CR>"] = { "accept_and_enter", "fallback" },
			["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
		},
	},
	completion = {
		menu = {
			border = "rounded",
		},
		documentation = {
			window = {
				border = "rounded",
			},
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		list = {
			selection = {
				auto_insert = false,
			},
		},
	},
	fuzzy = {
		implementation = "lua",
	},
	keymap = {
		["<C-e>"] = { "cancel", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "accept", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
	},
})

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true,
	virtual_lines = false,
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			format = { enable = false },
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME .. "/lua",
				},
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config(
	"yamlls",
	require("yaml-companion").setup({
		lspconfig = {
			settings = {
				yaml = {
					schemaStore = {
						enable = false,
						url = "",
					},
					schemaDownload = { enable = false },
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		},
	})
)

vim.lsp.enable({
	"ansiblels",
	"bashls",
	"fish_lsp",
	"lua_ls",
	"yamlls",
})
