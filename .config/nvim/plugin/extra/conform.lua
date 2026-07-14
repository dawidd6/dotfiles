vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	format_on_save = function(bufnr)
		if vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		fish = { "fish_indent" },
		["_"] = { "trim_whitespace", "trim_newlines" },
	},
})

vim.api.nvim_create_user_command("FormatDisable", function()
	vim.b.disable_autoformat = true
end, {
	desc = "Disable autoformat-on-save",
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
end, {
	desc = "Enable autoformat-on-save",
})
