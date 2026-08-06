vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("nvim-treesitter")
	.install({
		"go",
		"yaml",
	})
	:wait(300000)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(event)
		local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(event.buf, lang)
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
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
