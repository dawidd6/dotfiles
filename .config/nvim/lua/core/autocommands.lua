vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"git",
		"help",
		"man",
		"qf",
		"scratch",
	},
	callback = function(args)
		if args.match ~= "help" or not vim.bo[args.buf].modifiable then
			vim.keymap.set("n", "q", ":quit<CR>", { buffer = args.buf, silent = true })
		end
	end,
	desc = "Close special buffer types with <q>",
})

vim.api.nvim_create_autocmd({ "WinNew", "WinEnter", "BufWinEnter" }, {
	callback = function()
		if vim.w.todo_match then
			return
		end
		vim.w.todo_match = vim.fn.matchadd("Todo", [[\v<(TODO|FIXME|HACK|NOTE|WARNING|WARN|BUG)>]])
	end,
	desc = "Highlight common comments",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.txt" },
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
	desc = "Always open help in right split",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Don't continue comments on newlines",
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
	pattern = { ":", ">" },
	callback = function(args)
		vim.opt_local.completeopt = { "menu", "menuone", "longest" }
		vim.keymap.set("i", "<Tab>", "<C-X><C-V>", { buffer = args.buf })
		vim.keymap.set("i", "<CR>", function()
			return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
		end, { buffer = args.buf, expr = true })
	end,
	desc = "Use native command completion in command-line window",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight text briefly after yanking",
})

vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
	desc = "Auto-resize splits when window is resized",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Return to last edit position when opening files",
})

if not vim.g.vscode then
	vim.api.nvim_create_autocmd("BufReadPost", {
		callback = function(args)
			if vim.bo[args.buf].buftype ~= "" then
				return
			end

			local has_conflict = vim.api.nvim_buf_call(args.buf, function()
				return vim.fn.search([[^<<<<<<<]], "nw") > 0 and vim.fn.search([[^>>>>>>>]], "nw") > 0
			end)

			if has_conflict then
				vim.diagnostic.enable(false, { bufnr = args.buf })
				vim.notify("Conflicts detected! Diagnostics disabled.")
			end
		end,
		desc = "Disable diagnostics while git conflict markers are present",
	})

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

	vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
		nested = true,
		callback = function()
			if
				vim.bo.modified
				and vim.bo.modifiable
				and vim.bo.buftype == ""
				and vim.fn.expand("%") ~= ""
				and vim.api.nvim_get_mode().mode == "n"
			then
				vim.cmd("write")
			end
		end,
		desc = "Automatically save buffer when focus is lost",
	})

	if vim.fn.argc() == 0 then
		local cwd = assert(vim.uv.cwd())
		local session_dir = vim.fn.stdpath("state") .. "/sessions"
		local session_file = vim.fs.joinpath(session_dir, vim.fn.sha256(cwd) .. ".vim")

		vim.api.nvim_create_autocmd("VimEnter", {
			nested = true,
			callback = function()
				if vim.fn.filereadable(session_file) == 1 then
					vim.cmd("source " .. vim.fn.fnameescape(session_file))
				end
			end,
			desc = "Restore cwd session on startup",
		})

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				vim.fn.mkdir(session_dir, "p")
				vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
			end,
			desc = "Save cwd session on exit",
		})
	end
end
