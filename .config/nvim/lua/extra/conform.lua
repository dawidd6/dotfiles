vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	formatters_by_ft = {
		dockerfile = { "dockerfmt" },
		fish = { "fish_indent" },
		lua = { "stylua" },
		sh = { "shfmt" },
		["_"] = { "trim_whitespace", "trim_newlines" },
	},
})

local function format(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
		return
	end
	if vim.g.disable_autoformat then
		return
	end
	require("conform").format({
		bufnr = bufnr,
		timeout_ms = 1000,
		lsp_format = "fallback",
	})
end

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		format(args.buf)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "AutoSaveWritePre",
	callback = function(args)
		format(args.data.saved_buffer)
	end,
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
