vim.pack.add({
	{ src = "https://github.com/ray-x/lsp_signature.nvim" },
})

require("lsp_signature").setup({
	hint_enable = false,
})
