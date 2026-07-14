vim.pack.add({
	{ src = "https://github.com/niekdomi/conflict.nvim" },
})

require("conflict").setup({
	default_mappings = {
		current = "<LocalLeader>cc",
		incoming = "<LocalLeader>ci",
		both = "<LocalLeader>cb",
		base = "<LocalLeader>cB",
	},
})
