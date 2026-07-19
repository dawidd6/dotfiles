vim.loader.enable()

require("core.autocommands")
require("core.commands")
require("core.keymaps")
require("core.options")

if vim.g.vscode then
	require("plugins.autopairs")
	require("plugins.surround")
else
	require("vim._core.ui2").enable()
	-- TODO: switch to lua require
	vim.cmd("runtime! lua/plugins/*.lua")
end
