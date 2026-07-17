vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

local conform = require("conform")

conform.setup({
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

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	conform.format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
