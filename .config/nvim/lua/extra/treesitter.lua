vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
})

require("nvim-treesitter").install({
	"bash",
	"diff",
	"dockerfile",
	"fish",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"javascript",
	"json",
	"python",
	"ruby",
	"ssh_config",
	"toml",
	"typescript",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(event)
		local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(event.buf, lang)
		end
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		if event.data.spec.name == "nvim-treesitter" and event.data.kind == "update" then
			require("nvim-treesitter").update()
		end
	end,
})
