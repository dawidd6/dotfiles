vim.pack.add({
	{ src = "https://github.com/folke/sidekick.nvim" },
})

require("sidekick").setup({
	cli = {
		-- mux = {
		-- 	enabled = true,
		-- 	backend = "tmux",
		-- 	create = "window",
		-- },
	},
})

vim.keymap.set("n", "<Leader>a", ":Sidekick cli focus<CR>", { silent = true, desc = "Show LLM window" })
vim.keymap.set({ "n", "x" }, "<Leader>>", ":Sidekick cli prompt<CR>", { silent = true, desc = "Send LLM prompt" })
