-- Keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "X", '"_X')
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", ",", "<cmd>bprevious<CR>")
vim.keymap.set("n", ".", "<cmd>bnext<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Options
vim.o.autoindent = true -- Maintain indent of current line on new lines
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
require("lazy").setup({
	{ "folke/lazy.nvim", version = "*", lazy = false },
	{ "folke/todo-comments.nvim", config = true },
	{ "akinsho/bufferline.nvim", config = true },
	{ "akinsho/git-conflict.nvim", config = true },
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "NMAC427/guess-indent.nvim", config = true },
	{ "nvim-lualine/lualine.nvim", config = true },
	{ "johnfrankmorgan/whitespace.nvim", config = true },
	{ "kyazdani42/nvim-web-devicons", config = true },
	{ "windwp/nvim-autopairs", config = true },
	{ "folke/which-key.nvim", config = true },
	{
		"saghen/blink.cmp",
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
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"Mofiqul/vscode.nvim",
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
