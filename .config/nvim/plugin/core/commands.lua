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

vim.api.nvim_create_user_command("Sops", function()
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
	local group = vim.api.nvim_create_augroup("SopsDecryptedBuffer" .. bufnr, { clear = true })

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		buffer = bufnr,
		callback = function()
			if vim.uv.fs_stat(decrypted) == nil then
				return
			end

			local result = vim.system({ "sops", encrypted }, {
				text = true,
				env = {
					SOPS_EDITOR = 'sh -c \'cat "$NVIM_SOPS_DECRYPTED_FILE_PATH" > "$1"\' sh',
					NVIM_SOPS_DECRYPTED_FILE_PATH = decrypted,
				},
			}):wait()

			if result.code ~= 0 then
				error(result.stderr)
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout", "BufUnload" }, {
		group = group,
		buffer = bufnr,
		callback = function()
			if vim.uv.fs_stat(decrypted) ~= nil then
				vim.uv.fs_unlink(decrypted)
			end

			vim.api.nvim_del_augroup_by_id(group)
		end,
	})
end, {
	desc = "Edit current sops file via temporary decrypted file",
})
