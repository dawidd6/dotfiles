vim.pack.add({
	{ src = "https://github.com/nvimtools/hydra.nvim" },
})

local hydra = require("hydra")

hydra.setup({
	invoke_on_body = true,
})

hydra({
	name = "Resize window",
	mode = "n",
	body = "<C-w>r",
	config = {
		hint = {
			type = "statusline",
		},
	},
	heads = {
		{ "<Left>", "<C-w><", { desc = "narrower" } },
		{ "<Right>", "<C-w>>", { desc = "wider" } },
		{ "<Up>", "<C-w>+", { desc = "taller" } },
		{ "<Down>", "<C-w>-", { desc = "shorter" } },
	},
})
