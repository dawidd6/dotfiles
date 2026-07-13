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
	vim.fn.setreg("0", path)
end, {
	range = true,
	desc = "Copy current file path",
})

vim.api.nvim_create_user_command("CopyDirPath", function()
	local path = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")
	vim.fn.setreg("+", path)
	vim.fn.setreg("0", path)
end, {
	desc = "Copy current file's directory (or git repository) path",
})

vim.api.nvim_create_user_command("DiagnosticToggle", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle diagnostics for current buffer" })

vim.api.nvim_create_user_command("Sops", function()
	local encrypted = vim.api.nvim_buf_get_name(0)
	local dir = vim.fs.dirname(encrypted)
	local name = vim.fs.basename(encrypted)
	local decrypted = vim.fs.joinpath(dir, ".decrypted~" .. name)

	local decrypt_result = vim.system({ "sops", "-d", "--output", decrypted, encrypted }, { text = true }):wait()
	if decrypt_result.code ~= 0 then
		error(decrypt_result.stderr)
	end

	vim.cmd.edit(vim.fn.fnameescape(decrypted))

	local bufnr = vim.api.nvim_get_current_buf()
	local group = vim.api.nvim_create_augroup("SopsDecryptedBuffer" .. bufnr, { clear = true })

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		buffer = bufnr,
		callback = function()
			local encrypt_result = vim.system({ "sops", encrypted }, {
				text = true,
				env = {
					SOPS_EDITOR = 'sh -c \'cat "$NVIM_SOPS_DECRYPTED_FILE_PATH" > "$1"\' sh',
					NVIM_SOPS_DECRYPTED_FILE_PATH = decrypted,
				},
			}):wait()

			if encrypt_result.code ~= 0 then
				error(encrypt_result.stderr)
			end
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
