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

vim.keymap.set({ "n", "x" }, "<Leader>a", ":Sidekick cli prompt<CR>", { silent = true, desc = "Send LLM prompt" })
