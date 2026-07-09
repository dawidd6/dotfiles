vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MagicDuck/grug-far.nvim" },
})

local grug_far = require("grug-far")

grug_far.setup({
	transient = true,
	visualSelectionUsage = "auto-detect",
	windowCreationCommand = "topleft vsplit",
	helpLine = {
		enabled = false,
	},
	keymaps = {
		close = { n = "q" },
		applyNext = { n = "<space>" },
	},
})

vim.keymap.set({ "n", "x" }, "<Leader>sr", function()
	if grug_far.has_instance("grug-far") then
		grug_far.get_instance("grug-far"):open()
	else
		grug_far.open({ instanceName = "grug-far" })
	end
end, { desc = "Open search and replace" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "NvimTree",
	callback = function()
		if grug_far.has_instance("grug-far") then
			if grug_far.get_instance("grug-far"):is_open() then
				grug_far.get_instance("grug-far"):hide()
			end
		end
	end,
	desc = "Keep file explorer and search and replace sidebars exclusive",
})
