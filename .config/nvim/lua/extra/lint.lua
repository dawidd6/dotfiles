vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-lint" },
})

require("lint").linters_by_ft = {
	dockerfile = { "hadolint" },
	sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
	callback = function()
		if vim.bo.modifiable then
			require("lint").try_lint()
		end
	end,
})
