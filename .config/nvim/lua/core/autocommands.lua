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

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man", "qf", "git", "scratch", "checkhealth", "lspinfo" },
	callback = function(args)
		vim.keymap.set("n", "q", ":q<CR>", { buffer = args.buf, silent = true })
	end,
	desc = "Close special buffers with <q>",
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
	callback = function(args)
		vim.keymap.set("n", "q", ":q<CR>", { buffer = args.buf, silent = true })
	end,
	desc = "Close command-line window with <q>",
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

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("packadd nvim.undotree")
	end,
	desc = "Load built-in optional nvim plugins",
})
