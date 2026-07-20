vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvimtools/none-ls.nvim" },
	{ src = "https://github.com/gbprod/none-ls-shellcheck.nvim" },
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.fish_indent,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		require("none-ls-shellcheck.diagnostics"),
		require("none-ls-shellcheck.code_actions"),
	},
})
