vim.pack.add({
	{ src = "https://github.com/saghen/blink.indent" },
})

require("blink.indent").setup({
	static = {
		highlights = { "IblIndent" },
	},
	scope = {
		highlights = { "IblScope" },
	},
})
