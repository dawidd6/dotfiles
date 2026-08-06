vim.pack.add({
	{ src = "https://github.com/folke/sidekick.nvim" },
})

require("sidekick").setup({
	cli = {
		mux = {
			enabled = true,
			backend = "tmux",
			create = "split",
		},
	},
})

vim.keymap.set({ "n", "x" }, "ga", ":Sidekick cli prompt<CR>", { silent = true, desc = "Go ask AI" })
