vim.api.nvim_create_user_command("CopyLLMContext", function(opts)
	local path = vim.fn.expand("%:p")
	local start_line = opts.range > 0 and opts.line1 or vim.fn.line(".")
	local end_line = opts.range > 0 and opts.line2 or start_line
	local lang = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
	local selection = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")
	local diagnostics = {}

	for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
		local diagnostic_start = diagnostic.lnum + 1
		local diagnostic_end = (diagnostic.end_lnum or diagnostic.lnum) + 1

		if diagnostic_start <= end_line and diagnostic_end >= start_line then
			local severity = vim.diagnostic.severity[diagnostic.severity] or "UNKNOWN"
			local source = diagnostic.source and (" " .. diagnostic.source) or ""
			local code = diagnostic.code and (" [" .. diagnostic.code .. "]") or ""

			diagnostics[#diagnostics + 1] = string.format(
				"- %s%s%s at %d:%d: %s",
				severity,
				source,
				code,
				diagnostic_start,
				diagnostic.col + 1,
				diagnostic.message
			)
		end
	end

	local context = {
		string.format("Path: @%s:%d-%d", path, start_line, end_line),
		"",
		"Selection:",
		string.format("```%s", lang),
		selection,
		"```",
	}

	if #diagnostics > 0 then
		vim.list_extend(context, {
			"",
			"Diagnostics:",
			"```text",
			table.concat(diagnostics, "\n"),
			"```",
		})
	end

	vim.fn.setreg("+", table.concat(context, "\n"))
	vim.notify(path)
end, {
	range = true,
	desc = "Copy LLM context",
})

vim.api.nvim_create_user_command("CopyFilePath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, {
	desc = "Copy file path",
})

vim.api.nvim_create_user_command("CopyDirectoryPath", function()
	local path = vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
	vim.fn.setreg("+", path)
	vim.notify(path)
end, {
	desc = "Copy directory path",
})
