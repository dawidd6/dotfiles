vim.api.nvim_create_user_command("CopyFilePath", function(opts)
	local path = vim.fn.expand("%:p")
	if opts.range > 0 then
		if opts.line1 == opts.line2 then
			path = path .. ":" .. opts.line1
		else
			path = path .. ":" .. opts.line1 .. "-" .. opts.line2
		end
	end
	vim.fn.setreg("+", path)
	vim.notify(path)
end, {
	range = true,
	desc = "Print and copy file absolute path",
})

vim.api.nvim_create_user_command("CopyRelFilePath", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, {
	desc = "Print and copy file relative path",
})

vim.api.nvim_create_user_command("CopyDirPath", function()
	local path = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, {
	desc = "Print and copy directory absolute path",
})

vim.api.nvim_create_user_command("Terminal", function()
	local path = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")
	local shell = vim.fn.fnamemodify(vim.env.SHELL or vim.o.shell, ":t")
	vim.cmd("edit " .. vim.fn.fnameescape("term://" .. path .. "//" .. shell))
	vim.cmd("startinsert")
end, {
	desc = "Open terminal buffer in current file directory",
})
