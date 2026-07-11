vim.pack.add({
	{ src = "https://github.com/Mofiqul/vscode.nvim" },
})

require("vscode").setup()
vim.cmd.colorscheme("vscode")
