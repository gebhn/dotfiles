vim.loader.enable()

vim.pack.add {
	{ src = 'https://github.com/rktjmp/lush.nvim', name = 'lush' },
	{ src = 'https://github.com/zenbones-theme/zenbones.nvim', name = 'zenbones' },
	{ src = 'https://github.com/stevearc/conform.nvim', name = 'conform' },
	{ src = 'https://github.com/tronikelis/conflict-marker.nvim', name = 'conflict' },
	{ src = 'https://github.com/nvim-mini/mini.nvim', name = 'mini' },
}

vim.lsp.enable { 'bashls', 'clangd', 'gopls', 'lua_ls' }
