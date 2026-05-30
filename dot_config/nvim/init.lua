-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Filetypes
vim.filetype.add({
	pattern = {
		[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/ansible/.*%.ya?ml"] = "yaml.ansible",
	},
})

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
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.lsp.enable({
				"yamlls",
				"ansiblels",
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				["yaml.ansible"] = { "ansible_lint" },
				["yaml"] = { "yamllint" },
				["sh"] = { "shellcheck" },
				["fish"] = { "fish" },
			}
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
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
		"nvim-lua/plenary.nvim",
	},
	{
		"trevorhauter/gitportal.nvim",
		config = true,
	},
	{
		"ibhagwan/fzf-lua",
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		config = true,
	},
	{
		"karb94/neoscroll.nvim",
		config = true,
	},
	{
		"sphamba/smear-cursor.nvim",
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		config = true,
	},
	{
		"akinsho/bufferline.nvim",
		config = true,
	},
	{
		"akinsho/git-conflict.nvim",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"NMAC427/guess-indent.nvim",
		config = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = true,
	},
	{
		"johnfrankmorgan/whitespace.nvim",
		config = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function()
					require("whitespace-nvim").trim()
				end,
			})
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		"folke/which-key.nvim",
		config = true,
	},
	{
		"saghen/blink.cmp",
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
		"nvim-tree/nvim-tree.lua",
		config = true,
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
