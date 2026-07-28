-- vim.cmd.packadd("nvim-sops")
vim.pack.add({
	{ src = "https://github.com/dawidd6/nvim-sops" },
})

require("sops").setup()
