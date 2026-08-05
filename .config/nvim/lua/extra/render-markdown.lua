vim.pack.add({
	{ src = "https://github.com/meanderingprogrammer/render-markdown.nvim" },
})

require("render-markdown").setup({
	file_types = { "markdown", "md", "AgenticChat" },
	completions = { lsp = { enabled = true } },
	preset = "lazy",
})
