vim.pack.add({
	-- TODO: switch back when https://github.com/okuuva/auto-save.nvim/pull/83 is merged
	-- { src = "https://github.com/okuuva/auto-save.nvim" },
	{ src = "https://github.com/dawidd6/auto-save.nvim", version = "nested" },
})

require("auto-save").setup({
	trigger_events = {
		defer_save = {},
		cancel_deferred_save = {},
	},
	condition = function(buf)
		return vim.api.nvim_get_mode().mode == "n" and vim.bo[buf].buftype == ""
	end,
	nested = true,
})
