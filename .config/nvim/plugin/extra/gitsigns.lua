vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

local gitsigns = require("gitsigns")

gitsigns.setup()

vim.keymap.set("n", "gb", function()
	gitsigns.blame_line({ full = true })
end, { silent = true, desc = "Blame line" })
