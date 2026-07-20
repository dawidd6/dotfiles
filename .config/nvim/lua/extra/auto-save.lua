vim.pack.add({
	{ src = "https://github.com/okuuva/auto-save.nvim" },
})

require("auto-save").setup({
	noautocmd = true,
	trigger_events = {
		defer_save = {},
		cancel_deferred_save = {},
	},
})
