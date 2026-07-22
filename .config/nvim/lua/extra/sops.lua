local path = vim.fn.expand("~/repos/nvim-sops")
if vim.uv.fs_stat(path) then
	vim.opt.runtimepath:prepend(path)
	--vim.cmd.source(vim.fs.joinpath(path, "plugin/*.lua"))
else
	vim.pack.add({
		{ src = "https://github.com/dawidd6/nvim-sops" },
	})
end

require("sops").setup()
