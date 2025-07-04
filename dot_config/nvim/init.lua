-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = " "

-- General settings
vim.opt.expandtab = true
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.visualbell = true
vim.opt.writebackup = false
vim.opt.clipboard = "unnamedplus"

-- Keymaps
vim.keymap.set({ "n", "v" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { silent = true })
vim.keymap.set("v", "p", '"_dP', { silent = true })
vim.keymap.set('n', ',', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '.', ':bnext<CR>', { noremap = true, silent = true })

-- Plugin setup using lazy.nvim
require("lazy").setup({
	{ "akinsho/bufferline.nvim", config = true },
	{ "akinsho/git-conflict.nvim", config = true },
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "NMAC427/guess-indent.nvim", config = true },
	{ "nvim-lualine/lualine.nvim", config = true },
	{ "folke/noice.nvim", config = true },
	{ "johnfrankmorgan/whitespace.nvim", config = true },
	{ "kyazdani42/nvim-web-devicons", config = true },
	{ "windwp/nvim-autopairs", config = true },
	{ "folke/which-key.nvim", config = true },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
				}),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "buffer" },
				}),
			})
		end,
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
})
