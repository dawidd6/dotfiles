vim.api.nvim_create_user_command("CopyAbsoluteFilePath", function(opts)
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
end, { range = true, desc = "Print and copy absolute file path with optional line range" })

vim.api.nvim_create_user_command("CopyRelativeFilePath", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Print and copy relative file path" })

vim.api.nvim_create_user_command("CopyGitAbsoluteDirPath", function()
	local path = vim.fs.root(0, { ".git" })
	if not path then
		vim.notify("Not in git repository")
		return
	end
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Print and copy git absolute dir path" })

vim.api.nvim_create_user_command("CopyGitRelativeFilePath", function()
	local git_root_path = vim.fs.root(0, { ".git" })
	local file_path = vim.fn.expand("%:p")
	if not git_root_path then
		vim.notify("Not in git repository")
		return
	end
	local path = file_path:gsub("^" .. vim.pesc(git_root_path) .. "/", "")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Print and copy git relative file path" })

vim.api.nvim_create_user_command("Terminal", function()
	local path = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")
	local shell = vim.fn.fnamemodify(vim.env.SHELL or vim.o.shell, ":t")
	vim.cmd("edit " .. vim.fn.fnameescape("term://" .. path .. "//" .. shell))
	vim.cmd("startinsert")
end, { desc = "Open terminal buffer in git root dir or file dir" })

vim.api.nvim_create_user_command("Sops", function()
	local file_path = vim.fn.expand("%:p")

	vim.cmd("enew")
	vim.fn.termopen({ "sops", file_path }, {
		cwd = vim.fn.fnamemodify(file_path, ":h"),
	})
	vim.cmd("startinsert")
end, { desc = "Edit current file with sops" })

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update all vim.pack plugins" })

vim.api.nvim_create_user_command("ResizeWindow", function(opts)
	vim.cmd("vertical resize " .. vim.opt.columns:get() * (opts.args / 100.0))
end, { nargs = "*", desc = "Resize window vertically by given percent" })
