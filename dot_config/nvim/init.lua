-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- LSP: nvim-lspconfig
-- Lint: nvim-lint
require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		config = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"karb94/neoscroll.nvim",
		version = "*",
		config = true,
	},
	{
		"sphamba/smear-cursor.nvim",
		version = "*",
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		version = "*",
		config = true,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		config = true,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		config = true,
	},
	{
		"NMAC427/guess-indent.nvim",
		version = "*",
		config = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		version = "*",
		config = true,
	},
	{
		"johnfrankmorgan/whitespace.nvim",
		version = "*",
		config = true,
	},
	{
		"kyazdani42/nvim-web-devicons",
		version = "*",
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		version = "*",
		config = true,
	},
	{
		"folke/which-key.nvim",
		version = "*",
		config = true,
	},
	{
		"saghen/blink.cmp",
		version = "*",
		config = true,
		opts = {
			keymap = {
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "accept", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<Left>"] = { "hide", "fallback" },
				["<Right>"] = { "hide", "fallback" },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		version = "*",
		config = true,
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = true,
	},
	{
		"Mofiqul/vscode.nvim",
		version = "*",
		lazy = false,
		config = function()
			vim.cmd.colorscheme("vscode")
		end,
	},
}, {
	performance = {
		rtp = {
			reset = false,
		},
	},
})

-- Keymaps
vim.keymap.set({ "n", "v" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { silent = true })
vim.keymap.set("v", "p", '"_dP', { silent = true })
vim.keymap.set("n", ",", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", ".", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("n", "<Leader>f", ":NvimTreeFocus<CR>", { desc = "Tree Focus", silent = true })
vim.keymap.set("n", "<Leader>c", ":NvimTreeClose<CR>", { desc = "Tree Close", silent = true })
vim.keymap.set("n", "<Leader>d", ":bdelete<CR>", { desc = "Buffer Delete", silent = true })
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>", { desc = "Files Find", silent = true })
vim.keymap.set("n", "<Leader>s", ":Telescope live_grep<CR>", { desc = "String Search", silent = true })

-- Options
vim.o.autoindent = true
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.writebackup = false

-- AutoCMDs
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		require("whitespace-nvim").trim()
	end,
})
