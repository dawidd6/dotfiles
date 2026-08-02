vim.pack.add({
	{ src = "https://github.com/claydugo/browsher.nvim" },
})

require("browsher").setup({
	providers = {
		["gitlab"] = {
			url_template = "%s/-/blob/%s/%s",
			single_line_format = "#L%d",
			multi_line_format = "#L%d-%d",
		},
		["salsa"] = {
			url_template = "%s/-/blob/%s/%s",
			single_line_format = "#L%d",
			multi_line_format = "#L%d-%d",
		},
	},
})
