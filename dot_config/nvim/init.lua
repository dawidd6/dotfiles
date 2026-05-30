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
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/trevorhauter/gitportal.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/karb94/neoscroll.nvim" },
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/akinsho/git-conflict.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/johnfrankmorgan/whitespace.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/Mofiqul/vscode.nvim" },
})
require("gitportal").setup()
require("fzf-lua").setup()
require("telescope").setup()
require("neoscroll").setup()
require("smear_cursor").setup()
require("todo-comments").setup()
require("bufferline").setup()
require("git-conflict").setup()
require("gitsigns").setup()
require("guess-indent").setup()
require("lualine").setup()
require("nvim-autopairs").setup()
require("which-key").setup()
require("nvim-tree").setup()

-- LSP
vim.lsp.enable({
	"yamlls",
	"ansiblels",
})

-- Lint
do
	local lint = require("lint")

	lint.linters_by_ft = {
		["yaml.ansible"] = { "ansible_lint" },
		["yaml"] = { "yamllint" },
		["sh"] = { "shellcheck" },
		["fish"] = { "fish" },
	}

	vim.api.nvim_create_autocmd({
		"BufEnter",
		"BufWritePost",
		"InsertLeave",
	}, {
		callback = function()
			lint.try_lint()
		end,
	})
end

-- Format
require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
	},
})

-- Whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		require("whitespace-nvim").trim()
	end,
})

-- Completion
require("blink.cmp").setup({
	keymap = {
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "accept", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<Left>"] = { "hide", "fallback" },
		["<Right>"] = { "hide", "fallback" },
	},
})

-- Colorscheme
require("vscode").setup()
vim.cmd.colorscheme("vscode")

-- Keymaps
vim.keymap.set({ "n", "v" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { silent = true })
vim.keymap.set("v", "p", '"_dP', { silent = true })

vim.keymap.set("n", ",", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", ".", ":bnext<CR>", { silent = true })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

vim.keymap.set("n", "<Leader>c", ":NvimTreeClose<CR>", {
	desc = "Tree Close",
	silent = true,
})

vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>", {
	desc = "Files Find",
	silent = true,
})

vim.keymap.set("n", "<Leader>s", ":Telescope live_grep<CR>", {
	desc = "String Search",
	silent = true,
})

vim.keymap.set("n", "<Leader>d", ":bdelete<CR>", {
	desc = "Buffer Delete",
	silent = true,
})

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

-- Autocmds
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
