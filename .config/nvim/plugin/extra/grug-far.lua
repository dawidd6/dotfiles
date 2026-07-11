vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MagicDuck/grug-far.nvim" },
})

local grug_far = require("grug-far")

grug_far.setup({
	transient = true,
	visualSelectionUsage = "auto-detect",
	windowCreationCommand = "only",
	helpLine = {
		enabled = false,
	},
	openTargetWindow = {
		preferredLocation = "right",
	},
	keymaps = {
		close = { n = "q" },
		applyNext = { n = "<space>" },
	},
})

vim.keymap.set({ "n", "x" }, "<Leader>g", function()
	grug_far.open()
end, { silent = true, desc = "Open search and replace" })
