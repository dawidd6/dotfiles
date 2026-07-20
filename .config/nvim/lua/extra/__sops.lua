-- local path = vim.fn.expand("~/repos/nvim-sops")
-- vim.opt.runtimepath:prepend(path)
-- vim.opt.runtimepath:prepend(path)
-- vim.cmd.source(vim.fs.joinpath(path, "plugin/*.lua"))
--
-- vim.pack.add({
-- 	{ src = "https://github.com/dawidd6/nvim-sops" },
-- })
--
-- require("sops").setup()

-- TODO: find a plugin or make my own?
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

	local cleanup = function()
		vim.fs.rm(decrypted, { force = true })
		pcall(vim.api.nvim_del_augroup_by_id, group)
	end

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

	vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
		group = group,
		buffer = bufnr,
		callback = cleanup,
	})

	vim.api.nvim_create_autocmd("QuitPre", {
		group = group,
		callback = function()
			if vim.bo[bufnr].modified and vim.v.cmdbang ~= 1 then
				return
			end
			pcall(vim.api.nvim_buf_delete, bufnr, { force = vim.v.cmdbang == 1 })
			cleanup()
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

vim.api.nvim_create_autocmd("BufReadPost", {
	nested = true,
	callback = function(args)
		if
			vim.g.sops_auto_edit == false
			or vim.bo[args.buf].buftype ~= ""
			or vim.startswith(vim.fs.basename(args.file), ".decrypted~")
		then
			return
		end

		local is_sops_file = vim.api.nvim_buf_call(args.buf, function()
			return vim.fn.search([[ENC\[AES256_GCM]], "nw") > 0 and vim.fn.search([[sops]], "nw") > 0
		end)

		if is_sops_file then
			vim.cmd.SopsEdit()
		end
	end,
	desc = "Open sops files decrypted",
})
