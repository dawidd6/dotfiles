vim.pack.add({
	{ src = "https://github.com/okuuva/auto-save.nvim" },
})

require("auto-save").setup({
	trigger_events = {
		defer_save = {},
		cancel_deferred_save = {},
	},
	condition = function()
		return vim.api.nvim_get_mode().mode == "n"
	end,
})
