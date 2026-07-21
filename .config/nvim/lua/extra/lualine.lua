vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("lualine").setup({
	options = {
		section_separators = "",
		component_separators = "",
		disabled_filetypes = {
			statusline = { "NvimTree", "neo-tree" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 3 } },
		lualine_x = {
			"encoding",
			"fileformat",
			"filetype",
			"lsp_status",
			{
				function()
					return "󰊓 Z"
				end,
				cond = function()
					return vim.t["simple-zoom"] == "zoom"
				end,
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location", "searchcount", "selectioncount" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 3 } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "buffers" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
})
