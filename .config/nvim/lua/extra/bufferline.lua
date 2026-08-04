vim.pack.add({
	{ src = "https://github.com/akinsho/bufferline.nvim" },
})

require("bufferline").setup({
	options = {
		style_preset = require("bufferline").style_preset.minimal,
		offsets = {
			{
				filetype = "neo-tree",
				text = "File explorer",
				highlight = "Directory",
				separator = true,
			},
		},
	},
})
