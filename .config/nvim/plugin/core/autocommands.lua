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
			vim.keymap.set("n", "q", ":quit<CR>", { buffer = args.buf })
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

vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
	desc = "Auto-resize splits when window is resized",
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
