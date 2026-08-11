vim.pack.add({
	{ src = "https://github.com/chrisgrieser/nvim-early-retirement" },
})

require("early-retirement").setup({
	deleteBufferWhenFileDeleted = true,
})
