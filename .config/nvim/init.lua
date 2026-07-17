vim.loader.enable()

vim.cmd("runtime! lua/core/*.lua")

if vim.g.vscode then
	vim.env.XDG_DATA_HOME = (vim.env.SNAP_REAL_HOME or vim.env.HOME) .. "/.local/share"
	vim.opt.packpath:prepend(vim.env.XDG_DATA_HOME .. "/nvim/site")
	vim.cmd("runtime! lua/extra/autopairs.lua")
	vim.cmd("runtime! lua/extra/surround.lua")
else
	vim.cmd("runtime! lua/extra/*.lua")
end
