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

-- Plugin for useful functions
vim.pack.add({ { src = "https://github.com/nvim-lua/plenary.nvim" } })

-- Plugin for nice icons
vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-web-devicons" } })

-- Plugin for LSP configs
vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })
vim.lsp.enable({
	"ansiblels",
	"bashls",
	"yamlls",
})

-- Plugin for formatting
vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })
require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
	},
})

-- Plugin for opening git objects in web browser
vim.pack.add({ { src = "https://github.com/trevorhauter/gitportal.nvim" } })
require("gitportal").setup()

-- TODO: pick one
-- Plugin for picking things
vim.pack.add({ { src = "https://github.com/ibhagwan/fzf-lua" } })
require("fzf-lua").setup()

-- TODO: pick one
-- Plugin for picking things
vim.pack.add({ { src = "https://github.com/nvim-telescope/telescope.nvim" } })
require("telescope").setup()

-- Plugin for smooth scrolling
vim.pack.add({ { src = "https://github.com/karb94/neoscroll.nvim" } })
require("neoscroll").setup()

-- Plugin for cursor animation
vim.pack.add({ { src = "https://github.com/sphamba/smear-cursor.nvim" } })
require("smear_cursor").setup()

-- Plugin for highlighting special comments
vim.pack.add({ { src = "https://github.com/folke/todo-comments.nvim" } })
require("todo-comments").setup()

-- Plugin for buffer line
vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim" } })
require("bufferline").setup()

-- Plugin for status line
vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } })
require("lualine").setup()

-- Plugin for git integration
vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })
require("gitsigns").setup()

-- Plugin for git conflicts handling
vim.pack.add({ { src = "https://github.com/akinsho/git-conflict.nvim" } })
require("git-conflict").setup()

-- Plugin for guessing indentation
vim.pack.add({ { src = "https://github.com/NMAC427/guess-indent.nvim" } })
require("guess-indent").setup()

-- Plugin for handling whitespace
vim.pack.add({ { src = "https://github.com/johnfrankmorgan/whitespace.nvim" } })

-- Plugin for auto pairing
vim.pack.add({ { src = "https://github.com/windwp/nvim-autopairs" } })
require("nvim-autopairs").setup()

-- Plugin for showing next keys
vim.pack.add({ { src = "https://github.com/folke/which-key.nvim" } })
require("which-key").setup()

-- Plugin for completion
vim.pack.add({ "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp" })
require("blink.cmp").setup({
	fuzzy = {
		implementation = "lua",
	},
	keymap = {
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "accept", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<Left>"] = { "hide", "fallback" },
		["<Right>"] = { "hide", "fallback" },
	},
})

-- Plugin for file tree/explorer
vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua" } })
require("nvim-tree").setup()

-- Plugin for theme/colorcheme
vim.pack.add({ { src = "https://github.com/Mofiqul/vscode.nvim" } })
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
vim.keymap.set("n", "<Leader>c", ":NvimTreeClose<CR>", { desc = "Tree Close", silent = true })
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>", { desc = "Files Find", silent = true })
vim.keymap.set("n", "<Leader>s", ":Telescope live_grep<CR>", { desc = "String Search", silent = true })
vim.keymap.set("n", "<Leader>d", ":bdelete<CR>", { desc = "Buffer Delete", silent = true })

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
vim.o.updatetime = 300
vim.o.writebackup = false

-- Autocmds
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		require("whitespace-nvim").trim()
	end,
})
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

-- Diagnostics
vim.diagnostic.config({
	virtual_lines = { current_line = true }
})
