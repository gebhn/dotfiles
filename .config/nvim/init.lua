vim.loader.enable()

vim.pack.add {
	{ src = 'https://github.com/zenbones-theme/zenbones.nvim', name = 'zenbones' },
}

vim.lsp.enable { 'bashls', 'clangd', 'gopls', 'lua_ls' }
