vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	format_on_save = function()
		if not vim.g.disable_autoformat then
			return { timeout_ms = 1000, lsp_format = "never" }
		end
	end,
	formatters_by_ft = {
		dockerfile = { "dockerfmt" },
		fish = { "fish_indent" },
		lua = { "stylua" },
		sh = { "shfmt" },
		["_"] = { "trim_whitespace", "trim_newlines" },
	},
})

vim.api.nvim_create_user_command("FormatDisable", function()
	vim.g.disable_autoformat = true
end, {
	desc = "Disable autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.g.disable_autoformat = false
end, {
	desc = "Enable autoformat-on-save",
})
