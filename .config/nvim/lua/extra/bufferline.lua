vim.pack.add({
	{ src = "https://github.com/akinsho/bufferline.nvim" },
})

require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neotree",
				highlight = "NeotreeTabInactive",
			},
		},
	},
})
