local v = vim.version()

if v.minor < 11 then
	vim.api.nvim_echo({ { '0.11 or higher is required', 'ErrorMsg' } }, true, {})
	vim.cmd.sleep(2)
	vim.cmd.quit()
end

vim.lsp.enable { 'gopls', 'clangd', 'lua_ls' }

vim.pack.add {
	{ src = 'https://github.com/rktjmp/lush.nvim',             name = 'lush' },
	{ src = 'https://github.com/zenbones-theme/zenbones.nvim', name = 'zenbones' },
}
