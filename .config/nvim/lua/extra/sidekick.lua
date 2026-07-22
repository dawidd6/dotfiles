vim.pack.add({
	{ src = "https://github.com/folke/sidekick.nvim" },
})

require("sidekick").setup({
	cli = {
		win = {
			layout = "float",
			float = {
				width = 0.95,
				height = 0.95,
			},
		},
		-- mux = {
		-- 	enabled = true,
		-- 	backend = "tmux",
		-- 	create = "window",
		-- },
	},
})

vim.keymap.set("n", "<leader>A", ":Sidekick cli focus<CR>", { silent = true, desc = "Show LLM window" })
vim.keymap.set({ "n", "x" }, "<leader>a", ":Sidekick cli prompt<CR>", { silent = true, desc = "Send LLM prompt" })
