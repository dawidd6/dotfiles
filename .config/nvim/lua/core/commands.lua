vim.api.nvim_create_user_command("CopyFilePath", function(opts)
	local path = vim.fn.expand("%:p")
	if opts.range > 0 then
		if opts.line1 == opts.line2 then
			path = path .. ":" .. opts.line1
		else
			path = path .. ":" .. opts.line1 .. "-" .. opts.line2
		end
	end
	vim.print(path)
	vim.fn.setreg("+", path)
end, {
	range = true,
	desc = "Copy current file path",
})

vim.api.nvim_create_user_command("CopyDirPath", function()
	local path = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")
	vim.print(path)
	vim.fn.setreg("+", path)
end, {
	desc = "Copy current file's directory (or git repository) path",
})

vim.api.nvim_create_user_command("DiagnosticEnable", function()
	vim.diagnostic.enable(true, { bufnr = 0 })
end, { desc = "Enable diagnostics for current buffer" })

vim.api.nvim_create_user_command("DiagnosticDisable", function()
	vim.diagnostic.enable(false, { bufnr = 0 })
end, { desc = "Disable diagnostics for current buffer" })

vim.api.nvim_create_user_command("VerticalWindowResize", function(opts)
	vim.cmd("vertical resize " .. vim.opt.columns:get() * (opts.args / 100.0))
end, { nargs = "*", desc = "Resize window vertically by given percent" })

vim.api.nvim_create_user_command("HorizontalWindowResize", function(opts)
	vim.cmd("resize " .. ((vim.opt.lines:get() - vim.opt.cmdheight:get()) * (opts.args / 100.0)))
end, { nargs = "*", desc = "Resize window horizontally by given percent" })

vim.api.nvim_create_user_command("SopsEdit", function()
	local encrypted_bufnr = vim.api.nvim_get_current_buf()
	local encrypted = vim.api.nvim_buf_get_name(0)
	local dir = vim.fs.dirname(encrypted)
	local name = vim.fs.basename(encrypted)
	local decrypted = vim.fs.joinpath(dir, ".decrypted~" .. name)

	local decrypt_result = vim.system({ "sops", "-d", "--output", decrypted, encrypted }, { text = true }):wait()
	if decrypt_result.code ~= 0 then
		vim.notify(decrypt_result.stderr, vim.log.levels.ERROR)
		return
	end

	vim.cmd.edit(vim.fn.fnameescape(decrypted))

	local bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_delete(encrypted_bufnr, {})

	local group = vim.api.nvim_create_augroup("SopsDecryptedBuffer" .. bufnr, { clear = true })
	local modified = false

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		buffer = bufnr,
		callback = function()
			modified = vim.bo[bufnr].modified
		end,
	})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		buffer = bufnr,
		callback = function()
			if not modified then
				return
			end

			local encrypt_result = vim.system({ "sops", encrypted }, {
				text = true,
				env = {
					SOPS_EDITOR = 'sh -c \'cat "$NVIM_SOPS_DECRYPTED_FILE_PATH" > "$1"\' sh',
					NVIM_SOPS_DECRYPTED_FILE_PATH = decrypted,
				},
			}):wait()

			if encrypt_result.code ~= 0 then
				vim.notify(encrypt_result.stderr, vim.log.levels.ERROR)
				return
			end

			modified = false
		end,
	})

	vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout", "BufUnload" }, {
		group = group,
		buffer = bufnr,
		callback = function()
			vim.fs.rm(decrypted, { force = true })
			vim.api.nvim_del_augroup_by_id(group)
		end,
	})
end, {
	desc = "Edit current sops file via temporary decrypted file",
})

vim.api.nvim_create_user_command("SopsEnable", function()
	vim.g.sops_auto_edit = true
end, { desc = "Enable automatic sops editing" })

vim.api.nvim_create_user_command("SopsDisable", function()
	vim.g.sops_auto_edit = false
end, { desc = "Disable automatic sops editing" })

vim.api.nvim_create_user_command("GitBrowse", function(opts)
	local file = vim.api.nvim_buf_get_name(0)
	local root = vim.fs.root(0, { ".git" })
	if not root then
		vim.notify("Not inside a git repository", vim.log.levels.ERROR)
		return
	end
	local path = vim.fs.relpath(root, file)
	local args = { "git", "-C", root, "browse", path }
	if opts.range > 0 then
		table.insert(args, tostring(opts.line1))
		if opts.line2 ~= opts.line1 then
			table.insert(args, tostring(opts.line2))
		end
	end
	vim.system(args)
end, { range = true })
