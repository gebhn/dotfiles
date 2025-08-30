vim.loader.enable()

vim.g.loaded_matchparen = 1

vim.pack.add {
	{ src = 'https://github.com/zenbones-theme/zenbones.nvim', name = 'zenbones' },
}

vim.lsp.enable { 'bashls', 'clangd', 'gopls', 'lua_ls' }
