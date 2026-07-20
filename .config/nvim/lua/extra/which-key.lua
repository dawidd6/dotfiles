vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
})

require("which-key").setup({
	preset = "helix",
	delay = 0,
      sort = { "local", "order", "group", "alphanum", "mod" },
	filter = function(mapping)
		return mapping.desc and mapping.desc ~= ""
	end,
	icons = {
		mappings = false,
	},
})
