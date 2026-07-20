vim.pack.add({
	{ src = "https://github.com/nguyenvukhang/nvim-toggler" },
})

local toggler = require("nvim-toggler")

toggler.setup({
	inverses = {
		["me"] = "you",
	},
	remove_default_keybinds = true,
})

vim.keymap.set({ "n", "v" }, "<Leader>I", toggler.toggle, { silent = true, desc = "Invert current word" })
