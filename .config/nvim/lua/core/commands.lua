vim.api.nvim_create_user_command("CopyLLMContext", function(opts)
	local path = vim.fn.expand("%:p")
	local ref = path

	if opts.line1 ~= opts.line2 then
		ref = path .. ":" .. opts.line1 .. ":" .. opts.line2
	end

	local note = vim.fn.input("Prompt (optional): ")
	if note ~= "" then
		ref = ref .. "\n" .. note
	end

	vim.fn.setreg("+", ref)
	vim.notify(ref)
end, { desc = "Copy LLM context", range = true })

vim.api.nvim_create_user_command("CopyAbsoluteFilePath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Copy absolute file path" })

vim.api.nvim_create_user_command("CopyRelativeFilePath", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Copy relative file path" })

vim.api.nvim_create_user_command("CopyProjectRelativeFilePath", function()
	local path = vim.fs.relpath(vim.fs.root(0, { ".git" }) or vim.fn.getcwd(), vim.fn.expand("%:p")) or ""
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Copy project relative file path" })

vim.api.nvim_create_user_command("CopyProjectAbsoluteDirectoryPath", function()
	local path = vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Copy project absolute directory path" })

vim.api.nvim_create_user_command("CopyProjectRelativeDirectoryPath", function()
	local path = vim.fs.relpath(vim.fn.getcwd(), vim.fs.root(0, { ".git" }) or vim.fn.getcwd()) or ""
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Copy project relative directory path" })

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update plugins" })

vim.api.nvim_create_user_command("PackClean", function()
	local inactive = vim.iter(vim.pack.get())
		:filter(function(x)
			return not x.active
		end)
		:map(function(x)
			return x.spec.name
		end)
		:totable()
	if #inactive > 0 then
		vim.pack.del(inactive)
	end
end, { desc = "Clean plugins" })
